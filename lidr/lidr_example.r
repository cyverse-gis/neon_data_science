library(lidR)
library(rgdal)

lidr_options(verbose = TRUE, progress = TRUE)

# 1. Build a project (here, a single file catalog for the purposes of this example).
project <- catalog("C:/Dropbox/GitHubRepos/Old_lidR-devel/tests/4haMCPlot.laz")
plot(project)

# 2. Set some global catalog options
# For this dummy example, the clustering size is 80 m and the buffer is 15 m using
# a single core (because this example is run on the CRAN server when the package is submitted).
catalog_options(buffer = 15, multicore = 4, tiling_size = 120)

# 4. Build the function that analyzes each cluster of the catalog.
# The function's first argument is a LAS object. The internal routine takes care of
# this part. The other arguments can be freely choosen by the user. See the following
# template:
tree_area = function(las)
{
  if (is.null(las))
    return(NULL)
  
  # segment trees (in this example the low point density does not enable
  # accurate segmentation of trees. This is just a proof-of-concept)
  lastrees(las, algorithm = "li2012")
  
  # Here we used the function tree_metric to compute some metrics for each tree. This
  # function is defined later in the global environment.
  m = tree_metrics(las, myMetrics(X, Y, Z, buffer, treeID))
  
  # If min buffer is 0 it means the trees were at least partly in the non-buffered area, so we
  # want to keep these trees.
  # However, the trees that are on the edge of the buffered area will be counted
  # twice. So we must remove the trees on the right side and on the top side of the buffer
  # If max buffer is <= 2 it means that the trees belong inside the area of interest, on
  # the left side or the bottom side, or both.
  m = m[minbuff == 0 & maxbuff <= 2]
  
  # Remove buffering information that is no longer useful
  m[, c("minbuff","maxbuff") := NULL]
  
  return(m)
}

# This function enables users to extract, for a single tree, the position of the highest point
# and some information about the buffering position of the tree. The function tree_metrics takes
# care of mapping along each tree.
myMetrics <- function(x, y, z, buff, treeID)
{
  i = which.max(z)
  xcenter = x[i]
  ycenter = y[i]
  A = area(x,y)
  dat = matrix(c(x, y), nrow=length(x), ncol=2)
  ch = chull(dat)
  coords <- dat[c(ch, ch[1]), ]  
  sp_poly <- SpatialPolygons(list(Polygons(list(Polygon(coords)), ID=treeID[i])))
  minbuff = min(buff)
  maxbuff = max(buff)
  
  return(
    list(
      x = xcenter,
      y = ycenter,
      area = A,
      crowns=list(sp_poly),
      minbuff = minbuff,
      maxbuff = maxbuff
    ))
}

# Everything is now well defined, so now we can process over an entire catalog with
# hundreds of files (but in this example we use just one file...)

# 4. Process the project. The arguments of the user-defined function must
# belong in a labelled list. We also pass extra arguments to the function readLAS
# to load only X, Y and Z coordinates. This way we save a huge amount of memory, which
# can be used for the current process.
output = catalog_apply(project, tree_area, select = "xyz")

# 5. Post-process the output result (depending on the output computed). Here, each value
# of the list is a data.table, so rbindlist does the job:
output = data.table::rbindlist(output)

# Create a liast of polygons to store the crown chulls for now
list_of_SPols = output$crowns

# Now remove the crown informaiton from te output, to prepare to write the geojson
output = output[,1:4]

# Set the spatial coordinates and projection for the treelocs output file and write the geojson
coordinates(output)<-~x+y
proj4string(output) <- CRS("+proj=utm +zone=12 +datum=WGS84")
writeOGR(obj=output, dsn="C:/Dropbox/GitHubRepos/Old_lidR-devel/tests/treelocs.geojson", layer="treeslocs", driver="GeoJSON", overwrite_layer = T)

# Now we need to manipulate the crown polys to be able to coerse them to a SpatialPolygonsDataFrame
Spols <- SpatialPolygons(lapply(1:length(list_of_SPols), function(i) {
  Pol <- slot(list_of_SPols[[i]], "polygons")[[1]]
  slot(Pol, "ID") <- as.character(i)
  Pol
}))
# Get the polygon IDs
pid <- sapply(slot(Spols, "polygons"), function(x) slot(x, "ID"))
# Create dataframe with correct rownames
p.df <- data.frame( ID=1:length(Spols), row.names = pid)
# coersion to SpatialPolygonsDataFrame and write it out
Spols <- SpatialPolygonsDataFrame(Spols, p.df)
writeOGR(obj=Spols, dsn="C:/Dropbox/GitHubRepos/Old_lidR-devel/tests/trees.geojson", layer="trees", driver="GeoJSON", overwrite_layer = T)

# Plot it for fun
plot(output, pch=16, cex=0.5)
plot(Spols, lty=2, add=TRUE)
