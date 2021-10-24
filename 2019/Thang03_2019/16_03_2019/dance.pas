const maxn = 201; maxp = 200*200+1; fi = 'dance.inp'; fo = 'dance.out';
  INF = 100;
var a : array[0..1, 0..maxp] of int64;
  l : array[0..maxn] of longint;
  p : array[0..maxn] of int64;
  n, tests, t, i, j, id, pos, min_pos, max_pos : longint;
  ret : int64;

function max(a, b : int64) : int64;
begin
  if a > b then exit(a) else exit(b);
end;

begin
  assign(input, fi); reset(input);
  assign(output, fo); rewrite(output);
  readln(tests);

  for t := 1 to tests do begin
    readln(n);
    for i := 0 to n - 1 do read(l[i]);
    for i := 0 to n - 1 do read(p[i]);

    a[0][0] := 0; id := 0;
    pos := 0; max_pos := 0;
    for i := 0 to n - 1 do begin
      id := 1 - id;
      if l[i] > 0 then max_pos := pos + l[i];
      for j := 0 to max_pos do a[id][j] := -INF;
      for j := 0 to pos do a[id][j] := a[1 - id][j];
      min_pos := pos + l[i];
      if min_pos > max_pos then min_pos := max_pos;
      for j := max(0, l[i]) to min_pos do
        a[id][j] := max(a[id][j], p[i] + a[1 - id][j - l[i]]);

      pos := max_pos;
    end;

    ret := 0;
    for j := 0 to pos do ret := max(ret, a[id][j]);
    writeln(ret);
  end;
  close(input); close(output);
end.
