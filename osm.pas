unit osm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

procedure get_city(lon,lat: string; w, h : integer);


implementation
        uses math;
//http://pafciu17.dev.openstreetmap.org/?module=map&lat=40.1767698401&lon=44.50817107778&zoom=13&width=300&height=300

{
          public function lonToTile($long, $zoom){
                return (($long + 180) / 360) * pow(2, $zoom);
        }

        public function latToTile($lat, $zoom){
                return (1 - log(tan($lat * pi()/180) + 1 / cos($lat* pi()/180)) / pi()) /2 * pow(2, $zoom);
        }

}


{
  $destX = floor(($this->width/2)-$this->tileSize*($this->centerX-$this->lonToTile($markerLon, $this->zoom)));
  $destY = floor(($this->height/2)-$this->tileSize*($this->centerY-$this->latToTile($markerLat, $this->zoom)));
  $destY = $destY - imagesy($markerImg);

  imagecopy($this->image, $markerImg, $destX, $destY, 0, 0, imagesx($markerImg), imagesy($markerImg));

}

function lonToTile (lon : real; zoom : integer) : integer;
var n : real;
begin
    n := Power(2, zoom);
    Result := Trunc(((lon + 180) / 360) * n);
//    Result := (((lon) + 180)/360)*(math.power(2, zoom));
end;

function latToTile(lat : real; zoom : integer): integer;
var n : real;
begin
  n := Power(2, zoom);
  Result := Trunc((1 - (ln(Tan(lat * Pi / 180) + (1 /Cos(lat * Pi / 180))) / Pi)) / 2 * n);
end;

procedure get_city(lon,lat: string; w, h : integer);
begin
//http://pafciu17.dev.openstreetmap.org/?module=map&lat=40.1767698401&lon=44.50817107778&zoom=13&width=300&height=300
end;

end.

