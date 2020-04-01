#!/bin/bash -l

if [ "$2" = "install" ]
then
	if [ ! -f "$3" ]
	then
		echo "Need hostfile"
		exit 1
	fi
	gpssh -f $3 "yum install -y expat expat-devel proj proj-devel json-c json-c-devel gdal gdal-devel --user"
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/install/postgis.sql;
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/install/rtpostgis.sql;
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/install/postgis_comments.sql;
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/install/raster_comments.sql;
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/install/spatial_ref_sys.sql;
elif [ "$2" = "upgrade" ]
then
	echo "No upgrade for 2.5"
elif [ "$2" = "uninstall" ]
then
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/uninstall/uninstall_rtpostgis.sql;
	psql -d $1 -f $GPHOME/share/postgresql/contrib/postgis-2.5/uninstall/uninstall_postgis.sql;
else
	echo "Invalid option. Please try install, upgrade or uninstall"
fi
