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
    A    : integer; // количество побед команды А
    B    : integer; // количество побед команды Б
    draw : integer; // количество ничьих
  end;

  TGameLogic = Class(TObject)
    private
      team    : TTeam;   // основной состав команд
      teamOld : TTeam;   // копия состава для перезапуска модели
      teamNum : integer; // количество зверей в командах
      matches : integer; // количество сыгранных матчей
      stat    : TStat;   // статистика матчей
    public
      constructor Create(teamNum, matches : integer);
      function ReturnTeamNum() : integer;
      function ReturnMatchesNum() : integer;
      procedure CopyToOld();
      procedure ReturnTeam();
      procedure Add(teamVar : TTeamVar; num : integer; beast : TBeast);
      procedure Fight();
      function NowIsDead(teamVar : TTeamVar; num : integer) : boolean;
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


procedure TGameLogic.Fight;
var
  i,j : integer;
begin
  // члены команды А атакуют команду Б
  for i := 1 to self.teamNum do begin
    self.team.A[i].Attack(self.teamNum,self.team.B,self.team.A);
    for j := 1 to self.teamNum do begin
      // проверяем в кого прилетел удар из соперников (команды Б)
      if self.team.B[j].IsAttacked[1] and self.team.B[j].IsAttacked[2] then begin
        Write('Член команды А',i,' кинул яблоко в соперника Б',j,' ДВА РАЗА');
        Writeln(': У Б',j,' осталось ',self.team.B[j].ReturnHP,' ХП');
        self.team.B[j].ResetDamage;
      end
      else if self.team.B[j].IsAttacked[1] and
          not self.team.B[j].IsAttacked[2] then begin
        Write('Член команды А',i,' кинул яблоко в соперника Б',j);
        Writeln(': У Б',j,' осталось ',self.team.B[j].ReturnHP,' ХП');
        self.team.B[j].ResetDamage;
      end;
      // проверяем не прилетело ли по своим (команды А)
      if self.team.A[j].IsAttacked[1] and self.team.A[j].IsAttacked[2] then begin
        Write('Член команды А',i,' кинул яблоко в союзника  А',j,' ДВА РАЗА');
        Writeln(': У А',j,' осталось ',self.team.A[j].ReturnHP,' ХП');
        self.team.A[j].ResetDamage;
      end
      else if self.team.A[j].IsAttacked[1] and
          not self.team.A[j].IsAttacked[2] then begin
        Write('Член команды А',i,' кинул яблоко в союзника  А',j);
        Writeln(': У А',j,' осталось ',self.team.A[j].ReturnHP,' ХП');
        self.team.A[j].ResetDamage;
      end;
    end;
  end;

  // члены команды Б атакуют команду А
  for i := 1 to self.teamNum do begin
    self.team.B[i].Attack(self.teamNum,self.team.A,self.team.B);
    for j := 1 to self.teamNum do begin
      // проверяем в кого прилетел удар из соперников (команды А)
      if self.team.A[j].IsAttacked[1] and self.team.A[j].IsAttacked[2] then begin
        Write('Член команды Б',i,' кинул яблоко в соперника А',j,' ДВА РАЗА');
        Writeln(': У А',j,' осталось ',self.team.A[j].ReturnHP,' ХП');
        self.team.A[j].ResetDamage;
      end
      else if self.team.A[j].IsAttacked[1] and
          not self.team.A[j].IsAttacked[2] then begin
        Write('Член команды Б',i,' кинул яблоко в соперника А',j);
        Writeln(': У А',j,' осталось ',self.team.A[j].ReturnHP,' ХП');
        self.team.A[j].ResetDamage;
      end;
      // проверяем не прилетело ли по своим (команды Б)
      if self.team.B[j].IsAttacked[1] and self.team.B[j].IsAttacked[2] then begin
        Write('Член команды Б',i,' кинул яблоко в союзника  Б',j,' ДВА РАЗА');
        Writeln(': У Б',j,' осталось ',self.team.B[j].ReturnHP,' ХП');
        self.team.B[j].ResetDamage;
      end
      else if self.team.B[j].IsAttacked[1] and
          not self.team.B[j].IsAttacked[2] then begin
        Write('Член команды Б',i,' кинул яблоко в союзника  Б',j);
        Writeln(': У Б',j,' осталось ',self.team.B[j].ReturnHP,' ХП');
        self.team.B[j].ResetDamage;
      end;
    end;
  end;
end;

function TGameLogic.NowIsDead(teamVar: TTeamVar; num: integer): boolean;
begin
  case teamVar of
    A :
      if not self.team.A[num].IsAlive then NowIsDead := FALSE
      else NowIsDead := self.team.A[num].IsDead;
    B :
      if not self.team.B[num].IsAlive then NowIsDead := FALSE
      else NowIsDead := self.team.B[num].IsDead;
  end;
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
