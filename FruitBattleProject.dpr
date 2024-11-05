program FruitBattleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AnimalUnitClass in 'AnimalUnitClass.pas',
  GameLogicUnitClass in 'GameLogicUnitClass.pas';

var
  Game : TGameLogic;
  strTeamNum, strMatches : string;
  teamNum, matches : integer;  
  log : boolean; wrLog : char;  
  beast : char;
  i,j,k : integer;

begin
  try
    Writeln('!!! ����� ���������� �� ��������� ����� !!!');
    Writeln;
    
    teamNum := 0; strTeamNum := ' ';
    while (teamNum >= CmaxNumMemb) or (teamNum <= 0) do begin
      Write('������� ���������� ���������� � ������� (�� ����� 20): ');
      Readln(strTeamNum);
      try
        teamNum := StrToInt(strTeamNum);
      except
        teamNum := 0;
        strTeamNum := ' ';
      end;
    end;    

    matches := 0; strMatches := ' ';
    while (matches >= CmaxMatches) or (matches <= 0) do begin
      Write('������� ���������� ������ (�� ����� 1 000 000): ');
      Readln(strMatches);
      try
        matches := StrToInt(strMatches);
      except
        matches := 0;
        strMatches := ' ';
      end;
    end;

    log := FALSE; wrLog := ' ';
    while (wrLog <> '�') and (wrLog <> '�') do begin
        Write('�������� ��������� ����������� ([�]� [�]��): ');
        Readln(wrLog);
    end;
    if (wrLog = '�') then log := TRUE;
    Game := TGameLogic.Create(teamNum, matches, log);

    Writeln('--- �������: � ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> '�') and (beast <> '�') do begin
        Write('�������� ��������� ',i,' ([�]��� [�]�����): ');
        Readln(beast);
      end;
      case beast of
        '�' : Game.Add(A,i,raccoon);
        '�' : Game.Add(A,i,badger);
      end;
    end;
    Writeln;
    Writeln('--- �������: � ---');
    for i := 1 to Game.ReturnTeamNum() do begin
      beast := ' ';
      while (beast <> '�') and (beast <> '�') do begin
        Write('�������� ��������� ',i,' ([�]��� [�]�����): ');
        Readln(beast);
      end;
      case beast of
        '�' : Game.Add(B,i,raccoon);
        '�' : Game.Add(B,i,badger);
      end;
    end;
    Writeln;
    Write('� (');
    for i := 1 to Game.ReturnTeamNum() do 
      case Game.ReturnBeast(A,i) of
        badger  : Write(' ������');
        raccoon : Write(' ����');
      end;
    Write(' ) VS � (');
    for i := 1 to Game.ReturnTeamNum() do 
      case Game.ReturnBeast(B,i) of
        badger  : Write(' ������');
        raccoon : Write(' ����');
      end;
    Writeln(' )');

    // ������ ����
    for j := 1 to Game.ReturnMatchesNum() do begin
      Writeln('=== �������� ����: ',j,' ===');
      if Game.ReturnLog() then Writeln;

      // ������ �����
      k := 1;
      while not Game.Stop() do begin
        if Game.ReturnLog() then Writeln('--- �����: ',k,' ---');

        Game.Fight(); // ��� ����� ���������

        // ��� ����� �� ������ ������� �
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(A,i) then
            if Game.ReturnLog() then Writeln('�������� �',i,' ��������');
        // ��� ����� �� ������ ������� �
        for i := 1 to Game.ReturnTeamNum() do
          if Game.NowIsDead(B,i) then
            if Game.ReturnLog() then Writeln('�������� �',i,' ��������');

        k := k + 1;
        if Game.ReturnLog() then Writeln;
      end;

      // ���������� ������� ���������� �����
      if Game.ReturnLog() then
        case Game.ReturnWiner() of
          A    : Writeln('!! ���������� �����: ������� � !!');
          B    : Writeln('!! ���������� �����: ������� � !!');
          draw : Writeln('!! ���� ���������� ������ !!');
        end;
      Writeln;

      // ��������� ������ ������ �� ������
      Game.UnloadTeam();
    end;

    if Game.ReturnStat().A > Game.ReturnStat().B then Writeln('����� ����������: ������� �');
    if Game.ReturnStat().A < Game.ReturnStat().B then Writeln('����� ����������: ������� �');
    if Game.ReturnStat().A = Game.ReturnStat().B then Writeln('����� ����������: �����!');

    Writeln;
    Writeln('=== ���������� ������ ===');
    Writeln('������� �: ', (Game.ReturnStat().A/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('������� �: ', (Game.ReturnStat().B/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('������:    ', (Game.ReturnStat().draw/Game.ReturnMatchesNum() *100):3:1,' %');

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
