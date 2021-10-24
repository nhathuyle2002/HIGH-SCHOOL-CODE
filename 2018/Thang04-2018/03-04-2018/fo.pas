program Shortest_Path_by_Ford_Bellman;
const
        max = 100;
        maxC = 10000;
var
        c: array[1..max, 1..max] of Integer;
        d: array[1..max] of Integer;
        Trace: array[1..max] of Integer;
        n, S, F: Integer;

procedure LoadGraph;
var
        i, m: Integer;
        u, v: Integer;
begin
        ReadLn(n, m, S, F);
        for u := 1 to n do
        for v := 1 to n do
        if u = v then c[u, v] := 0 else c[u, v] := maxC;
        for i := 1 to m do ReadLn(u, v, c[u, v]);
end;

procedure Init;
var
        i: Integer;
begin
        for i := 1 to n do
        begin
                d[i] := c[S, i];
                Trace[i] := S;
        end;
end;

procedure Ford_Bellman;
var
        Stop: Boolean;
        u, v, CountLoop: Integer;
begin
        CountLoop := 0;
        repeat
                Stop := True;
                for u := 1 to n do
                        for v := 1 to n do
                                if d[v] > d[u] + c[u, v] then
                                begin
                                        d[v] := d[u] + c[u, v];
                                        Trace[v] := u;
                                        Stop := False;
                                end;
                Inc(CountLoop);
        until Stop or (CountLoop >= n - 2);
end;

procedure PrintResult;
begin
        if d[F] = maxC then
                WriteLn('Path from ', S, ' to ', F, ' not found')
        else
        begin
                WriteLn('Distance from ', S, ' to ', F, ': ', d[F]);
                while F <> S do
                begin
                Write(F, '<-');
                F := Trace[F];
                end;
                WriteLn(S);
        end;
end;

begin
        Assign(Input, 'MINPATH.INP'); Reset(Input);
        Assign(Output, 'MINPATH.OUT'); Rewrite(Output);
        LoadGraph;
        Init;
        Ford_Bellman;
        PrintResult;
        Close(Input);
        Close(Output);
end.
