unit GameLogicUnitClass;


interface

uses
  System.SysUtils,
  AnimalUnitClass; // in 'AnimalUnitClass.pas';

const
  CmaxMatches = 1000000; // максимальное количество сыгранных матчей

type
  TTeamVar = (A,B,draw);

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
      log     : boolean; // подробное логирование
      stat    : TStat;   // статистика матчей
      winer   : TTeamVar;
    public
      constructor Create(teamNum, matches : integer; log : boolean); overload;
      function ReturnTeamNum() : integer;
      function ReturnMatchesNum() : integer;
      function ReturnLog() : boolean;
      procedure UnloadTeam();
      procedure Add(teamVar : TTeamVar; num : integer; beast : TBeast);
      procedure Fight();
      function NowIsDead(teamVar : TTeamVar; num : integer) : boolean;
      function Stop() : boolean;
      function ReturnWiner(): TTeamVar;
      function ReturnStat(): TStat;
  End;


implementation

{ TGameLogic }

constructor TGameLogic.Create(teamNum, matches: integer; log : boolean);
begin
  self.teamNum   := teamNum;
  self.matches   := matches;
  self.log       := log;
  self.stat.A    := 0;
  self.stat.B    := 0;
  self.stat.draw := 0;
  self.winer     := draw;
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
        if self.log then begin
          Write('Член команды А',i,' кинул яблоко в соперника Б',j,' ДВА РАЗА');
          Writeln(': У Б',j,' было ',self.team.B[j].ReturnHP + 4,' осталось ',self.team.B[j].ReturnHP,' ХП');
        end;
        self.team.B[j].ResetDamage;
      end
      else if self.team.B[j].IsAttacked[1] and
          not self.team.B[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды А',i,' кинул яблоко в соперника Б',j);
          Writeln(': У Б',j,' было ',self.team.B[j].ReturnHP + 2,' осталось ',self.team.B[j].ReturnHP,' ХП');
        end;
        self.team.B[j].ResetDamage;
      end;
      // проверяем не прилетело ли по своим (команды А)
      if self.team.A[j].IsAttacked[1] and self.team.A[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды А',i,' кинул яблоко в союзника  А',j,' ДВА РАЗА');
          Writeln(': У А',j,' было ',self.team.A[j].ReturnHP + 4,' осталось ',self.team.A[j].ReturnHP,' ХП');
        end;
        self.team.A[j].ResetDamage;
      end
      else if self.team.A[j].IsAttacked[1] and
          not self.team.A[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды А',i,' кинул яблоко в союзника  А',j);
          Writeln(': У А',j,' было ',self.team.A[j].ReturnHP + 2,' осталось ',self.team.A[j].ReturnHP,' ХП');
        end;
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
        if self.log then begin
          Write('Член команды Б',i,' кинул яблоко в соперника А',j,' ДВА РАЗА');
          Writeln(': У А',j,' было ',self.team.A[j].ReturnHP + 4,' осталось ',self.team.A[j].ReturnHP,' ХП');
        end;
        self.team.A[j].ResetDamage;
      end
      else if self.team.A[j].IsAttacked[1] and
          not self.team.A[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды Б',i,' кинул яблоко в соперника А',j);
          Writeln(': У А',j,' было ',self.team.A[j].ReturnHP + 2,' осталось ',self.team.A[j].ReturnHP,' ХП');
        end;
        self.team.A[j].ResetDamage;
      end;
      // проверяем не прилетело ли по своим (команды Б)
      if self.team.B[j].IsAttacked[1] and self.team.B[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды Б',i,' кинул яблоко в союзника  Б',j,' ДВА РАЗА');
          Writeln(': У Б',j,' было ',self.team.B[j].ReturnHP + 4,' осталось ',self.team.B[j].ReturnHP,' ХП');
        end;
        self.team.B[j].ResetDamage;
      end
      else if self.team.B[j].IsAttacked[1] and
          not self.team.B[j].IsAttacked[2] then begin
        if self.log then begin
          Write('Член команды Б',i,' кинул яблоко в союзника  Б',j);
          Writeln(': У Б',j,' было ',self.team.B[j].ReturnHP + 2,' осталось ',self.team.B[j].ReturnHP,' ХП');
        end;
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

function TGameLogic.ReturnLog: boolean;
begin
  ReturnLog := self.log;
end;

function TGameLogic.ReturnMatchesNum: integer;
begin
  ReturnMatchesNum := self.matches;
end;

function TGameLogic.ReturnStat: TStat;
begin
  ReturnStat.A := self.stat.A;
  ReturnStat.B := self.stat.B;
  ReturnStat.draw := self.stat.draw;
end;

procedure TGameLogic.UnloadTeam;
var
  i : integer;
begin
  for i := 1 to self.teamNum do begin
    self.team.A[i].Free();
    self.team.A[i] := TAnimal.Create(self.teamOld.A[i].ReturnBeast);
    self.team.B[i].Free();
    self.team.B[i] := TAnimal.Create(self.teamOld.B[i].ReturnBeast);
  end;
end;

function TGameLogic.ReturnTeamNum: integer;
begin
  ReturnTeamNum := self.teamNum;
end;

function TGameLogic.ReturnWiner: TTeamVar;
begin
  ReturnWiner := self.winer;
end;

function TGameLogic.Stop() : boolean;
var
  teamAdead, teamBdead : boolean;
  i : integer;
begin
  teamAdead := TRUE;
  teamBdead := TRUE;
  for i := 1 to self.teamNum do begin
    if self.team.A[i].IsAlive then teamAdead := FALSE;
    if self.team.B[i].IsAlive then teamBdead := FALSE;
  end;
  if teamAdead and teamBdead then
    begin
      self.stat.draw := self.stat.draw + 1;
      self.winer := draw;
      Stop := TRUE;
    end;
  if not teamAdead and teamBdead then
    begin
      self.stat.A := self.stat.A + 1;
      self.winer := A;
      Stop := TRUE;
    end;
  if teamAdead and not teamBdead then
    begin
      self.stat.B := self.stat.B + 1;
      self.winer := B;
      Stop := TRUE;
    end;
  if not teamAdead and not teamBdead then Stop := FALSE;
end;

procedure TGameLogic.Add;
begin
  case teamVar of
    A :
      begin
        self.team.A[num]    := TAnimal.Create(beast);
        self.teamOld.A[num] := TAnimal.Create(beast);
      end;
    B :
      begin
        self.team.B[num]    := TAnimal.Create(beast);
        self.teamOld.B[num] := TAnimal.Create(beast);
      end;
  end;
end;
end.
