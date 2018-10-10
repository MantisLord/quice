{*******************************************************}
{                                                       }
{                "About", version 2.0                   }
{                                                       }
{       Copyright (c) 2006-2008 "Indomit Soft"          }
{                                                       }
{  Original code is About.pas                           }
{  Created: Komin Mikhail                               }
{  Last updated: 29.01.2006                             }
{  Modifed: Komin Mikhail                               }
{                                                       }
{*******************************************************}
{                                                       }
{ ������ ������ �������� ����� "� ���������..."         }
{                                                       }
{*******************************************************}
{
var
  F: TAboutBox;
begin
  F:=TAboutBox.MyCreate(Self);
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;
}


unit About;

interface

uses Windows, SysUtils, Forms,  Classes, Graphics, Dialogs, Math,
     Controls, StdCtrls, ExtCtrls, ActnList, ExtActns, Registry, JvExControls, JvPoweredBy,
  System.Actions;

type
  TAboutBox = class(TForm)
    ActionList1: TActionList;
    BrowseURL1: TBrowseURL;
    Panel2: TPanel;
    Bevel1: TBevel;
    OKButton: TButton;
    Panel1: TPanel;
    lblVersion: TLabel;
    lblAutorName: TLabel;
    LinkSite: TLabel;
    Image1: TImage;
    edWebMoneyU: TEdit;
    edWebMoneyE: TEdit;
    edWebMoneyR: TEdit;
    edWebMoneyZ: TEdit;
    lbDesc: TLabel;
    PayPal: TLabel;
    BrowseURL2: TBrowseURL;
    lbdbversion: TLabel;
    Label1: TLabel;
    JvPoweredByJVCL1: TJvPoweredByJVCL;
    lbprojectwebsite: TLabel;
    procedure FormShow(Sender: TObject);
    procedure LinkSiteClick(Sender: TObject);
    procedure PayPalClick(Sender: TObject);
  private
    procedure InitializeCaptions;
    { Private declarations }
  public
    dbversion: string;
    constructor MyCreate (AOwner: TComponent);
    { Public declarations }
  end;

implementation

uses StrUtils, Functions, MyDataModule;

{$R *.dfm}

function GetFileVersion(FileName: string; var Major, Minor, Release, Build: Word): Boolean;
var
  Size, Size2: DWORD;
  Pt, Pt2: Pointer;
begin
  Result:= False;
  (*** Get version information size in exe ***)
  Size:= GetFileVersionInfoSize(PChar(FileName),Size2);
  (*** Make sure that version information are included in exe file ***)
  if Size > 0 then
  begin
    GetMem(Pt, Size);
    GetFileVersionInfo(PChar(FileName), 0, Size, Pt);
    VerQueryValue(Pt, '\', Pt2, Size2);
    with TVSFixedFileInfo(Pt2^) do
    begin
      Major:= HiWord(dwFileVersionMS);
      Minor:= LoWord(dwFileVersionMS);
      Release:= HiWord(dwFileVersionLS);
      Build:= LoWord(dwFileVersionLS);
    end;
    FreeMem(Pt, Size);
    Result:= True;
  end;
end;

procedure TAboutBox.InitializeCaptions;
var
  Major, Minor, Release, Build: Word;
begin
  // ����������� ������
  if GetFileVersion(Application.ExeName, Major, Minor, Release, Build) then
    lblVersion.Caption:= Format('Version %d.%d.%d.%d',[Major, Minor, Release, Build])
  else
    lblVersion.Caption:='';
end;

procedure TAboutBox.FormShow(Sender: TObject);
begin
  InitializeCaptions;
  lbdbversion.Caption := dbversion;
end;

procedure TAboutBox.LinkSiteClick(Sender: TObject);
begin
  BrowseURL1.URL:='https://github.com/Ravie/quice/releases';
  BrowseURL1.Execute;
end;

constructor TAboutBox.MyCreate(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;
         
procedure TAboutBox.PayPalClick(Sender: TObject);
begin
  BrowseURL2.URL:='http://sourceforge.net/donate/index.php?group_id=196709';
  BrowseURL2.Execute;
end;

end.
