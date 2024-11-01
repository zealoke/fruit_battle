unit GameLogicUnitClass;


interface

uses
  System.SysUtils,
  AnimalUnitClass; // in 'AnimalUnitClass.pas';

type
  TTeamVar = (A,B);

  // массивы с описанием членов команд
  TTeam = record
    A : TAnimalTeam;
    B : TAnimalTeam;
  end;

  TStat = record
    A    : integer; // количество побед команды ј
    B    : integer; // количество побед команды Ѕ
    draw : integer; // количество ничьих
  end;

  TGameLogic = Class(TObject)
    private
      team    : TTeam;   // основной состав команд
      teamOld : TTeam;   // копи€ состава дл€ перезапуска модели
      teamNum : integer; // количество зверей в командах
      matches : integer; // количество сыгранных матчей
      stat    : TStat;   // статистика матчей
    public
      constructor Create(teamNum, matches : integer);
      function ReturnTeamNum() : integer;
      function ReturnMatchesNum() : integer;
      procedure Add(teamVar: TTeamVar; num : integer; beast : TBeast);
      procedure CopyToOld();
      procedure ReturnTeam();
  End;


implementation

{ TGameLogic }

constructor TGameLogic.Create(teamNum, matches: integer);
begin
  self.teamNum   := teamNum;
  self.matches   := matches;
  self.stat.A    := 0;
  self.stat.B    := 0;
  self.stat.draw := 0;
end;


procedure TGameLogic.CopyToOld;
begin
  self.teamOld := self.team;
end;

function TGameLogic.ReturnMatchesNum: integer;
begin
  ReturnMatchesNum := self.matches;
end;

procedure TGameLogic.ReturnTeam;
begin
  self.team := self.teamOld;
end;

function TGameLogic.ReturnTeamNum: integer;
begin
  ReturnTeamNum := self.teamNum;
end;

procedure TGameLogic.Add;
begin
  case teamVar of
    A : self.team.A[num] := TAnimal.Create(beast);
    B : self.team.B[num] := TAnimal.Create(beast);
  end;
end;
end.
