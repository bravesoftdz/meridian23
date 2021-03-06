unit gpspipe;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

const   fStartingGPS =   'Starting GPS...';
  fConnectingGPS = 'GPS Connecting ...';
  fGPSFixed =    'GPS Fixed...';
  fGPSUpdated = 'GPS updated...';
  fGPSShuttingDown = 'Shutting down GPS...';
  fGPSStopped = 'GPS stopped...';

  Type
    TShowStatusEvent = procedure(lon, lat, Statsus: String) of Object;

    TMyThread = class(TThread)
    private

      lat, lon : string;
 //     fix : boolean;
      f : text;
      t : byte;
      FOnShowStatus: TShowStatusEvent;
      procedure ShowStatus;
    protected
      procedure Execute; override;
    public
      fStatusText : string;
      Constructor Create(CreateSuspended : boolean);
      property OnShowStatus: TShowStatusEvent read FOnShowStatus write FOnShowStatus;
      property latitude: string read lat;
      property longitude: string read lon;
      property Terminated;
 //     property fixed : boolean read fix;
    end;



//function get_thread_count : integer;

implementation
   uses unix, baseunix;
 //   var ThreadCount : integer;

//       function get_thread_count : integer;
//       begin
 //        Result := ThreadCount;
 //      end;
    {
       procedure inc_thread_count;
       begin
         inc(ThreadCount);
       end;

       procedure dec_thread_count;
       begin
         dec(ThreadCount);
       end;
     }

   constructor TMyThread.Create(CreateSuspended : boolean);
   var s : string;
   begin
           FreeOnTerminate := True;
           inherited Create(CreateSuspended);
    //       fix := false;
           t := 0;

  end;

  procedure TMyThread.ShowStatus;
  // this method is executed by the mainthread and can therefore access all GUI elements.
  begin
    if Assigned(FOnShowStatus) then
    begin
      FOnShowStatus(lat, lon, fStatusText);
    end;
  end;

  procedure TMyThread.Execute;
  var
    newStatus : string;

     s, pid, ppid : string;
  begin

   fStatusText := fStartingGPS;
    Synchronize(@Showstatus);
//            unix.popen (f, '/usr/bin/meridian23_get_location 2>&1', 'R');
              unix.popen (f, '/opt/meridian23/location/meridian23_get_location 2>&1', 'R');
          //  reset (f);

          s := '';
          fStatusText := fConnectingGPS;
          Synchronize(@Showstatus);

    repeat

   //    writeln ('entered 0 repeat');
       readln (f, s);
//       writeln (' get ' + s);
    until Copy(s,1,3) = 'pid';
       readln (f, pid);
//       writeln (pid);
  {  repeat
       writeln ('entered 1 repeat');
       readln (f, s);
       writeln (' got ' + s);
    until Copy(s,1,3) = 'ppid';

    readln (f, ppid);
    writeln (ppid);
   }

while (not Terminated) {or not (eof(f)) }do begin
    s := '';
    repeat
       readln (f, s);
    until Copy(s,1,3) = 'lon';
    readln (f,lon);
 //   longitude := lon;
    s := '';
    repeat
       readln (f, s);
    until  Copy(s,1,3) = 'lat';
    readln (f,lat);
 //   latitude := lat;
    inc(t);    //writeln (' t = ' + inttostr(t));
    if t > 223 then t := 23; //just make sure that no overflow occurs;

    if t = 1 then fStatusText := fGPSFixed + ' lon ' + lon + ', lat ' + lat ;
    if t > 1 then fStatusText := fGPSUpdated + ' lon ' + lon + ', lat ' + lat ;
       // if NewStatus <> fStatusText then
        //  begin
        //    fStatusText := newStatus;
            Synchronize(@Showstatus);
         // end;
end;
    // if Terminated
    fStatusText := fGPSShuttingDown;
    Synchronize (@Showstatus);

    writeln ('closing pipe');

   // unix.PClose(f);
    writeln ('pipe closed');
  //  dec(ThreadCount);
 //   fix := false;
  baseunix.FpKill(strtoint(pid), baseunix.SIGKILL);
 fStatusText := fGPSStopped;
    Synchronize (@Showstatus);

  end;



initialization
//ThreadCount := 0;

end.

