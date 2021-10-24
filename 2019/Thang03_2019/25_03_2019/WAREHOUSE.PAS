{$mode objfpc}
uses crt;
const
  MaxN = 100; MaxC = 100;
  fi = 'Warehouse.inp';
  fo = 'warehouse.out';
var
  a, b, trace, delta: array[1..2*MaxN + 2] of integer;
  g, f, c: array[1..2*MaxN + 2,1..2*MaxN + 2] of integer;
  m, n, s, t: integer;
  con: Boolean;

Procedure Init;
var
  i, j, sa, sb: integer;
begin
    fillchar(g, sizeof(g), 0);
    fillchar(f, sizeof(f),0);
    assign(input, fi); reset(input);
    readln(m, n);
    s:=1; t:= m + n + 2;
    sa:= 0; sb:= 0; con:= true;
    for i:= 1 to t do
     for j:= 1 to t do
      c[i,j]:= MaxC;
    for i:= 1 to m do
    begin
        read(a[i]);
        sa:= sa + a[i];
        c[s, i+1]:= 0; g[s, i+1]:=a[i];
    end;
    readln;
    for i:= 1 to n do
    begin
        read(b[i]);
        sb:= sb + b[i];
        c[i + m + 1, t]:= 0; g[i + m + 1, t]:=b[i];
    end;
    readln;
    if sa<>sb then
    begin
        con:= false;
        exit;
    end;
    for i:= 1 to m do
    begin
        for j:= 1 to n do
        begin
            read(c[i + 1, j + m + 1]);
            c[j + m + 1, i + 1]:= -c[i + 1, j + m + 1];
            g[i + 1, j + m + 1]:= MaxC;
        end;
        readln;
    end;
    close(input);
end;

function min(a, b:integer):integer;
begin
    if a < b then min:= a else min:= b;
end;

function FordBellman: Boolean;
var
  stop: Boolean;
  u, v, countloop: integer;
  d: array[1..MaxN] of integer;
  ct: array[1..2*MaxN + 2, 1..2*MaxN + 2] of integer;
begin
    ct:= c;
    fillchar(trace, sizeof(trace), 0);
    for u:= 1 to t do d[u]:= MaxC;
    trace[s]:= s; delta[s]:= MaxC;
    for u:= 1 to t do
    if g[s, u] - f[s, u] > 0 then
    begin
        d[u]:= c[s, u];
        trace[u]:= s;
        delta[u]:= g[s,u] - f[s,u];
    end
    else
    begin
        delta[u]:= MaxC; d[u]:= MaxC;
    end;
    countloop:=0;
    repeat
      stop:= true;
      for u:=1 to t do
        for v:=1 to t do
          if d[v] > d[u] + c[u, v] then
          begin
              if f[u, v] < g[u, v] then
              begin
                  trace[v]:= u;
                  stop:= false;
                  d[v]:= d[u] + c[u, v];
                  delta[v]:= min(delta[u], g[u, v] -f[u, v]);
              end
              else
              if f[v, u] > 0 then
              begin
                  trace[v]:= -u;
                  stop:= false;
                  d[v]:= d[u] + c[u, v];
                  delta[v]:= min(delta[u], f[v, u]);
              end;
          end;
        inc(countloop);
    until stop or (countloop >= n + m);
    c:= ct;
    if d[t] = MaxC then FordBellman:= false
    else FordBellman:= true;
end;

Procedure IncFlow;
var
  incvalue, u, v: integer;
begin
    incvalue:= delta[t];
    v:= t;
    repeat
      u:= trace[v];
      if u > 0 then f[u, v]:= f[u, v] + incvalue
      else
      begin
          u:= -u;
          f[v, u]:= f[v, u] - incvalue;
      end;
      v:= u;
    until v = s;
end;

Procedure Result3;
var
  i, j: integer;
  mincost: longint;
begin
    assign(output, fo); rewrite(output);
    mincost:= 0;
    for i:= 1 to m do
      for j:= 1 to n do
        mincost:= mincost + f[i + 1, j + m + 1]*c[i + 1, j + m + 1] + f[j +m + 1, i + 1]*c[j + m + 1, i + 1];
        write(mincost);
      close(output);
end;

BEGIN
    Init;
    If con then
    repeat
      if not FordBellman then break;
      IncFlow;
    until false;
    Result3;
END.

