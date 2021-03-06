unit ui;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, StdCtrls, ShellCtrls, Buttons,
  gpspipe{,IntfGraphics}{ ,BGRABitmap, BGRABitmapTypes};

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Panel1: TPanel;
    StatusBar1: TStatusBar;

    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label6Click(Sender: TObject);
    procedure ListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure SpeedButton2Click(Sender: TObject);
  private

     procedure ShowStatus(lon, lat, status: string);
    //AImage :   TLazIntfImage;
    { private declarations }
  public
         MyGPSThread : gpspipe.TMyThread;
    { public declarations }
  end;

{
  type TProcessThread = class(TThread)
  protected
    procedure Execute; override;

  public
    lon, lat : string;
    fixed  : boolean;
    constructor Create;

  end;

 }

procedure OpenContactImage (jid : string; rlat, rlon : real);
var
  Form1: TForm1;
  sharing : boolean;
 // ProcessThread : TProcessThread;
implementation

uses openmap, mxmpp, maint, contacts, debug, unix;
{$R *.lfm}
{ TForm1 }
  {
constructor TProcessThread.Create;
  begin
    inherited Create( false);
    Self.FreeOnTerminate := true;
    fixed := false;
  end;

procedure TProcessThread.Execute;
var f : text;
  s : string;
begin
  while not Self.Terminated do begin
    {- Do some heavy work }


  end;
  {- free by myself at last ! }
  debug.OutString('thread finished');
end;
    }
procedure TForm1.FormCreate(Sender: TObject);
begin
    sharing := false;
  Form1.Caption:='Meridian23';
  Form1.Width:=800;
  Form1.Height:=425;

  Panel1.Align := alClient;
  Panel1.Caption:='';

  Label6.Visible := true;
  Label6.Caption := 'I solemnly swear that I am up to no good';

  Button4.Color:= clRed;
  Button4.Caption:='!';
  ListBox1.Visible:=false;
  Memo1.Visible:= false;
  Edit1.Visible:= false;
  Edit2.Visible:= false;
  Edit3.Visible:= false;
  Button1.Visible:= false;
  Label1.Visible:= false;
  Label2.Visible:= false;
  Label3.Visible:= false;

  Button2.Visible:= false;
  Button3.Visible:= false;
  Label4.Visible:=false;
  Label5.Visible:=false;
  Label4.Caption:='GPS';
  Label5.Caption:='Share' + #10 + 'Location';
  Button2.Caption:='Start';
  Button3.Caption:='Start';
  Button4.Visible:=false;
  Button5.Visible:= false;
  Button5.Caption:='update map';

  Edit1.Text:= 'someuser@somejabber.org';
  Edit2.Text:= '';
  Edit2.EchoMode:= emPassword;
  Edit3.Text:='5222';
  Button1.Caption:= 'Login';
  Panel1.Visible:= true;

  Label1.Caption:='User';
  Label2.Caption:='Password';
  Label3.Caption:='Port';

  //ShowMessage ('GetUserDir ' + SysUtils.GetUserDir);
  //ShowMessage ('GetAppConfigDir, false ' + SysUtils.GetAppConfigDir(false));

  maint.start;
  Contacts.InitContacts;
   {
  Contacts.AddContact('bbb@bbb.bb','b b', 'bbbbbbbb');
    Contacts.AddContact('aaa@aaa.aa','a a', 'aaaaaaaa');
      Contacts.AddContact('yyy@yyy.yy','y y', 'yyyyyyyy');
        Contacts.AddContact('fff@fff.ff','f f', 'ffffffff');
          Contacts.AddContact('vvv@vvv.vv','v v', 'vvvvvvvv');
          //Contacts.RemoveContact('bbb@bbb.bb');
          Contacts.AddContact('aaa@aaa.aa','a b', 'bbbbbb');
          Contacts.ListContacts;
           ListBox1.Items.Assign(Contacts.ContactList); //need to do that every time when contact removed
           }
//           {$IFDEF FPC_LITTLE_ENDIAN}
  //         debug.OutString('fpc_little_endian');
    //       {$ENDIF}
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
  //showmessage ('onpaint');

end;

procedure TForm1.FormShow(Sender: TObject);
begin

end;

procedure TForm1.Label6Click(Sender: TObject);
begin
 // Memo1.Visible:= true;
  Edit1.Visible:= true;
  Edit2.Visible:= true;
  Edit3.Visible:= true;
  Button1.Visible:= true;
  Label1.Visible:= true;
  Label2.Visible:= true;
  Label3.Visible:= true;
  Button2.Visible:= true;
  Button3.Visible:= false;
  Label4.Visible:=true;
  Label5.Visible:=true;
  Button4.Visible:=true; // do not press
  Label6.Visible:=false;
   ListBox1.Visible:=true;
   Button5.Visible:=true;
end;

procedure TForm1.ListBox1SelectionChange(Sender: TObject; User: boolean);
var jid_, res_, s : string;
begin
    debug.OutString(ListBox1.Items.Strings[ListBox1.ItemIndex]);

    jid_ := ListBox1.Items.Strings[ListBox1.ItemIndex];
    res_ := Contacts.GetContactRes(jid_);
    if res_ <> Contacts.jid_not_found then begin
       s := jid_ + '/' + res_;
       StatusBar1.SimpleText:='Requesting coordinates from ' + s;
               mxmpp.send_message(s, mxmpp.coord_request);
    end;
end;


procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  showmessage ('Please, don''t press this button again!')
end;

procedure TForm1.Button1Click(Sender: TObject); //login
begin
   //Panel1.Visible:= false;
   if mxmpp.IsLoggedIn = false then begin
      Button1.Caption:= 'Logout';
      Edit1.Visible:= false;
      Edit2.Visible:= false;
      Edit3.Visible:= false;
      Label1.Visible:=false;
      Label2.Visible:=false;
      Label3.Visible:=false;
      //Button2.Visible:=false;
      //Button3.Visible:=false;
      mxmpp.Open(Edit1.Text, Edit2.Text, Edit3.Text);
   end
   else
   begin
     Button1.Caption:= 'Login';
     Edit1.Visible:= true;
     Edit2.Visible:= true;
     Edit3.Visible:= true;
     Label1.Visible:=true;
     Label2.Visible:=true;
     Label3.Visible:=true;
     //Button2.Visible:=true;
     //Button3.Visible:=true;
     mxmpp.Close;
     end;

end;

procedure CheckGPSButtonStatus(status : string);
begin
   if status = gpspipe.fConnectingGPS then Form1.Button2.Enabled:= false;
   if Copy(status, 1, 9) = Copy(gpspipe.fGPSFixed, 1, 9) then Form1.Button2.Enabled:= true;
   if status = gpspipe.fGPSShuttingDown then Form1.Button2.Enabled:=false;
   if status = gpspipe.fStartingGPS then Form1.Button2.Enabled:=false;
   if Copy(status, 1, 11) = Copy(gpspipe.fGPSUpdated,1, 11) then Form1.Button2.Enabled:=true;
   if status = gpspipe.fGPSStopped then Form1.Button2.Enabled:=true;
end;

procedure TForm1.ShowStatus(lon, lat, status : string);

begin
   debug.OutString('got coords');
   debug.OutString(lon);
   debug.OutString(lat);
   debug.OutString(status);
   StatusBar1.SimpleText:=status;
   CheckGPSButtonStatus(status);

end;

procedure TForm1.Button2Click(Sender: TObject);   //gps button
begin
  if Button2.Caption = 'Start' then begin
     Button2.Enabled:= false;
     Button3.Visible:= true;

     Button2.Caption:='Stop';
     StatusBar1.SimpleText:= gpspipe.fStartingGPS;

     //   if (MyGPSThread = nil) then begin
        //    if (Form1.MyGPSThread = nil) {and (gpspipe.get_thread_count < 1)} then begin
           MyGPSThread := gpspipe.TMyThread.Create(true);

           MyGPSThread.OnShowStatus:= @ShowStatus;
           MyGPSThread.Resume;
       // end;
        { if (ProcessThread <> nil) and (ProcessThread.Terminate)
     ProcessThread := TProcessThread.Create; // Thread will free itself when ready.
     ProcessThread.Execute;}
  end
  else
  begin
    Button2.Enabled:=false;
     Button3.Visible:=false;
     Button3.Caption:='Start';
     Button2.Caption:='Start';
//     ProcessThread.Terminate;
     StatusBar1.SimpleText:=gpspipe.fGPSShuttingDown;
     MyGPSThread.Terminate;
//  while MyGPSThread <> nil ;
  end;
end;

procedure OpenContactImage (jid : string; rlat, rlon : real);
var tile : openmap.TOSMTile;
  path_to_file : string;
  markX, markY : integer;
begin
  Form1.StatusBar1.SimpleText := 'location of your friend ' + jid + ' received';
//  Form1.Image1.Picture.Bitmap.LoadFromFile(p);
  path_to_file:= openmap.omGetTileFile(rlat, rlon, 16);
  Form1.Image1.Picture.LoadFromFile(path_to_file);
  tile := openmap.omGetTile(rlat, rlon, 16);
  markX := openmap.MarkerX(tile, rlat, rlon);
  markY := openmap.MarkerY(tile, rlat, rlon);

  Form1.Image1.Picture.Bitmap.Canvas.Brush.Color  := clGreen;

  Form1.Image1.Picture.Bitmap.Canvas.Brush.Style := bsSolid;
  Form1.Image1.Picture.Bitmap.Canvas.Ellipse(markX-7, markY-7,markX+7, markY+7);
  Form1.Image1.Picture.Bitmap.Canvas.Line(markX-7, markY-7,markX + 7, markY + 7);
  Form1.Image1.Picture.Bitmap.Canvas.Line(markX+7, markY-7,markX - 7, markY + 7);

  Form1.Image1.Picture.Bitmap.Canvas.Font.Color  := clBlue;
  Form1.Image1.Picture.Bitmap.Canvas.Brush.Style := bsclear;
  Form1.Image1.Picture.Bitmap.Canvas.Font.Size   := 13;
  Form1.Image1.Picture.Bitmap.Canvas.TextOut(markX + 10, markY-20, jid);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if Button3.Caption = 'Start' then begin
     Button3.Caption:= 'Stop';
     sharing := true;
  end
  else
  begin
     Button3.Caption:='Start';
     sharing := false;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ShowMessage('Please, don''t press this button again!');
end;

procedure TForm1.Button5Click(Sender: TObject);
//begin
  {   if MyGPSThread <> nil then begin
     debug.OutString(MyGPSThread.longitude);
     debug.OutString(MyGPSThread.latitude);

     end;
   }
     var jid_, res_, s : string;
begin
  debug.OutString('item index ' + inttostr(ListBox1.ItemIndex));

  if ListBox1.ItemIndex >= 0 then begin
      debug.OutString(ListBox1.Items.Strings[ListBox1.ItemIndex]);

      jid_ := ListBox1.Items.Strings[ListBox1.ItemIndex];
      res_ := Contacts.GetContactRes(jid_);
      if res_ <> Contacts.jid_not_found then begin
          s := jid_ + '/' + res_;
          StatusBar1.SimpleText:='Requesting coordinates from ' + s;
               mxmpp.send_message(s, mxmpp.coord_request);
    end;


  end
  else ShowMessage('nothing to update');

end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: char);
begin
   if NOT (key IN ['0'..'9', #8]) then begin
key := #0;
exit;
end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  if MyGPSThread <> nil then begin
     if MyGPSThread.Terminated <> true then begin
     StatusBar1.SimpleText:='Terminating threads';
     Application.ProcessMessages;
     MyGPSThread.Terminate;

     //TerminateThread(MyGPSThread.ThreadId);

     repeat

     until MyGPSThread.Terminated;
     sleep(2000);
     //WaitForThreadTerminate(MyGPSThread.ThreadID, 2000);
     //CloseThread(MyGPSThread.ThreadID);
     //MyGPSThread.fStatusText = gpspipe.fGPSStopped;
     end;
 end;

  ShowMessage ('Mischief managed!')
end;


end.

