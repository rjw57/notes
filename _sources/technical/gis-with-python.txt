Using Python to interoperate with GIS systems
=============================================

A *geographical information system* is, according to `Wikipedia
<http://en.wikipedia.org/wiki/Geographic_information_system>`_:

    [...] a system designed to capture, store, manipulate, analyze, manage, and present all types of geographically
    referenced data. The acronym GIS is sometimes used to mean geographical information science or geospatial
    information studies; these latter terms refer to the academic discipline or career of working with geographic
    information systems. In the simplest terms, GIS is the merging of cartography, statistical analysis, and database
    technology.

In more terse terms, it is a database system tuned for the manipulation of datasets representing geographic areas or
maps on the ground. As one might expect from a vertical industry, existing solutions tend to be monolithic and very
proprietary with some exceptions. They tend to be interoperable only insofar as they interoperate with the 500lb gorilla
of the field: `ArcGIS <http://www.esri.com/software/arcgis/index.html>`_.

A GIS database usually consists not of a single database file but as a collection of related files specifying regions of
interest, maps, geological information, etc. In this note, I'll focus on parsing one of the common formats used in GIS:
the ``.SHP`` shapefile format and its commonly occurring brother ``.DBF`` format. The end goal being understanding a
little of the datafile layout used conventionally in GISs and the visualisation of the regions overlayed on
satellite-like imagery.

File formats
------------

Among the more open formats is the *shapefile* format which is maintained as an open format by `ESRI
<http://www.esri.com/>`_. Polygon-based datasets would appear to often be stored in this format but this format on its
own only allows for the storage of one or more polygons each being defined by a closed set of 2D vertices.

In order to associate a polygon on the ground with some other information, GIS datasets usually have an accompanying
database table; each row in the table being associated with a shape and the ordering being consistent with the ordering
presented in the shapefile. A common format for supplying this data is the ``.DBF`` format harking back to the days of
dBase. Remember that dBase first originated in 1979! Other conventions include the use of the more modern (and open)
xBase format or one could even, if so inclined, store associated data records in a CSV file.

In addition to the ``.DBF`` and ``.SHP`` files one may also have a ``.SHX`` file which provides an index into the
``.SHP`` file for fast indexing or for handling ``.SHP`` files which exceed the memory capabilities of the machine.
Since any sane software would a) ``mmap`` the shape file for access and b) in these days of 64-bit Operating Systems be
running with more address space than it knows what to do with, I'll ignore the ``.SHX`` file for the moment.

Finally one often finds an associated ``.PRJ`` file which specifies the geographic projection the shapefile uses. Yes,
ladies and gentlemen, the shapefile's only reason to be is to specify 2D points on the Earth's surface but there is no
defined standard projection which is used. Instead this knowledge must be transmitted in a side-channel. The ``.PRJ``
format itself won't be discussed here beyond saying it is in a format known as *Well Known Text* (snappy!) and is fairly
transparent in describing a geographic projection.

Projections
-----------

The surface of the Earth is a 2D manifold and hence any point on it can be associated with a pair of co-ordinates. This
is where the standardisation ends. The shapefile contains *no* information on the projection used. It is just a set of
raw 2D point co-ordinates. There are many ways to specify a geographic projection including the WKT format described
above. Fortunately the `pyproj <http://code.google.com/p/pyproj/>`_ library for Python interfaces with the `proj.4
<http://trac.osgeo.org/proj/>`_ library to provide geographic projection conversion.

In my dataset, the points were specified using the `British National Grid
<http://en.wikipedia.org/wiki/Ordnance_Survey_National_Grid>`_ which is standardised as `EPSG:27700
<http://spatialreference.org/ref/epsg/27700/>`_. Ultimately I will want to output my data as a KML file and so I shall
need to convert my co-ordinates between projections. The KML documentation is somewhat terse in its description of the
projection used:

    Latitude and longitude measurements are standard lat-lon projection with WGS84 datum.

Some Googling revealed that this corresponds to `EPSG:4326 <http://spatialreference.org/ref/epsg/4326/>`_. The pyproj
library can easily convert between these projections. For example, the Sullom Voe oil terminal in the Shetlands has grid
co-ordinates 0439668, 1175316 which can be converted to latitude and longitude by pyproj:

.. code-block:: pycon

    >>> import pyproj

    >>> # Set up the projections:
    >>> bng_proj = pyproj.Proj(init='epsg:27700')   # The British National Grid
    >>> kml_proj = pyproj.Proj(init='epsg:4326')    # Latitude/longitude with WGS84 datum

    >>> # Specify grid co-ordinates in a list.
    >>> # We only transform one co-ordinate here, but multiple co-ordinates could be specified.
    >>> x = [ 439668 ]
    >>> y = [ 1175316 ]

    >>> # Transform the points and display the result.
    >>> lng, lat = pyproj.transform(bng_proj, kml_proj, x, y)
    >>> print(lng, lat)
    ([-1.2805632099057114], [60.45979108000527])

Parsing shapefiles
------------------

The `pyshp <http://code.google.com/p/pyshp/>`_ library can be used to parse shapefiles. It will automatically load
``.DBF`` files when present to allow record retrieval from the file:

.. code-block:: pycon

    >>> import shapefile

    >>> # Use the shapefile.Reader class to read a shapefile
    >>> sf = shapefile.Reader('Oxon/Archpoly.shp')

    >>> # The shapes() method returns a list of shapes in the file
    >>> shapes = sf.shapes()
    >>> print(len(shapes))
    295

    >>> # The points field of a shape gives the vertices of the polygon.
    >>> print(shapes[0].points[0:3])
    [[436910.6238059889, 204996.4696261965], [436924.0632555837, 204995.03003827424], [436929.6863872546, 204990.94120868953]]

    >>> # If an associated DBF was found, the field names can be accessed.
    >>> print(sf.fields[1:4])
    [['PRN', 'N', 7, 0], ['PRD', 'C', 50, 0], ['FRM', 'C', 50, 0]]

    >>> # As can the records themselves.
    >>> records = sf.records()
    >>> print(records[0])
    [1599, 'Anglo-Saxon', 'Site of', 'ANGLO-SAXON CEMETERY', 'None', '                ', 437, 205, '1.56442e-003']

Writing KML files
-----------------

Wiring these two things together made writing the ``shp2kml`` tool very easy indeed. In fact `the source code
<https://github.com/rjw57/pygis/blob/master/src/pygis/shp2kml.py>`_ is less than 200 lines.

References
----------

Context
~~~~~~~

* The `Geographic information system <http://en.wikipedia.org/wiki/Geographic_information_system>`_ article on Wikipedia.
* The `Shapefile <http://en.wikipedia.org/wiki/Shapefile>`_ article on Wikipedia.
* `KML reference documentation <http://code.google.com/apis/kml/documentation/kmlreference.html>`_.

Software
~~~~~~~~

* `pyshp <http://code.google.com/p/pyshp/>`_ --- a Python shapefile library
* `pyproj <http://code.google.com/p/pyproj/>`_ --- a Python binding to a library for performing geographic projections
