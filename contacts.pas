unit Contacts;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;
 const jid_not_found = 'jid not found';
type Tcontact = class (TObject)
     jid, resource, fn, lon, lat : string;
end;

procedure InitContacts;
procedure AddContact(jid, fn, resource : string);
procedure RemoveContact(jid : string);
procedure UpdateCoords ( jid, lon, lat : string);
procedure ListContacts;
function GetContactRes(jid : string) : string;
   var ContactList : TStringList;


implementation
   uses debug;



procedure AddContact(jid, fn, resource : string);
var contact : TContact;
begin
      contact := TContact.Create;
      contact.jid:=jid;
      contact.fn:=fn;
      contact.resource:=resource;
   If  ContactList.IndexOf(jid) = -1 then begin //contact does not exist
      ContactList.AddObject(jid, contact);
   end;
//      contact.Free;
end;

procedure RemoveContact(jid : string);
var i : integer;
begin
   i := ContactList.IndexOf(jid);
   if i <> -1 then begin
      ContactList.Delete(i);
   end;
end;

function GetContactRes(jid : string) : string;
var i : integer;
begin
    i := ContactList.IndexOf(jid);
    if i <> -1 then begin
      Result := TContact(ContactList.Objects[i]).resource;
    end
    else
    begin
      Result := jid_not_found;
    end;
end;

procedure UpdateCoords ( jid, lon, lat : string);
var i : integer;
begin
      i := ContactList.IndexOf(jid);
      if i <> -1 then begin
      TContact(ContactList.Objects[i]).lon := lon;
      TContact(ContactList.Objects[i]).lat:= lat;
      end;
end;

procedure InitContacts;
var cont : Tcontact;
begin
ContactList := TStringList.Create;
//ContactList.Duplicates:=dupIgnore;
ContactList.OwnsObjects:= true;
ContactList.Sorted:=true;
{
cont := TContact.Create;
ContactList.AddObject('* all_contacts', cont);
cont := TContact.Create;
ContactList.AddObject('* me', cont);
}
end;

procedure ListContacts;
var i : integer;
begin
   for i := 0 to ContactList.Count -1 do begin
     debug.OutString(TContact(ContactList.Objects[i]).jid + ' ' + TContact(ContactList.Objects[i]).fn );
   end;
end;

end.























