program FruitBattleProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  AnimalUnitClass in 'AnimalUnitClass.pas',
  GameLogicUnitClass in 'GameLogicUnitClass.pas';

var
  Game : TGameLogic;
  teamNum, matches : integer;
  log : boolean;
  stat : TStat;
  i,j,k : integer;
  beast,wrLog : char;

begin
  try
    Writeln('!!! ����� ���������� �� ��������� ����� !!!');
    Writeln;

    Write('������� ���������� ���������� � �������: ');
    Readln(teamNum);

    Write('������� ���������� ������: ');
    Readln(matches);

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

    Game.CopyToOld(); // ������ ������ �������� ��� �����������
    Writeln;

    // ������ ����
    for j := 1 to Game.ReturnMatchesNum() do begin
      Writeln('=== �������� ����: ',j,' ===');
      if Game.ReturnLog() then Writeln;

      // ������ �����
      k := 1;
      while not Game.Stop() do begin
        if Game.ReturnLog() then Writeln('--- �����: ',k,' ---');

        Game.Fight; // ��� ����� ���������

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
      if Game.ReturnLog then
        case Game.ReturnWiner of
          A    : Writeln('!! ���������� �����: ������� � !!');
          B    : Writeln('!! ���������� �����: ������� � !!');
          draw : Writeln('!! ���� ���������� ������ !!');
        end;
      Writeln;

      // ��������� ������ ������ �� ������
      Game.ReturnTeam;
    end;

    stat := Game.ReturnStat();
    if stat.A > stat.B then Writeln('����� ����������: ������� �');
    if stat.A < stat.B then Writeln('����� ����������: ������� �');
    if stat.A = stat.B then Writeln('����� ����������: �����!');

    Writeln;
    Writeln('=== ���������� ������ ===');
    Writeln('������� �: ', (stat.A/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('������� �: ', (stat.B/Game.ReturnMatchesNum *100):3:1,' %');
    Writeln('������:    ', (stat.draw/Game.ReturnMatchesNum *100):3:1,' %');

    Readln;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
