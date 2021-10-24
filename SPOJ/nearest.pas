const MAXN = 100000;
        fi='ss.inp';
        fo='ss.out';

type TPoint = record x, y : real; end;
var
        a : array[1..MAXN] of TPoint;
        b, c : array[1..MAXN] of longint;
        n, i : longint;
        di : real;

procedure readInput;
var
        f : text; i : longint;
begin
        assign(f, fi); reset(f);
        readln(f, n);
        for i := 1 to n do begin
        readln(f, a[i].x, a[i].y);
        b[i] := i;
        end;
        close(f);
end;

procedure sort(l, h : longint);
var
        i, j : longint; t, x : TPoint;
begin
        i := l; j := h; x := a[random(h - l + 1) + l];
        repeat
                while a[i].x < x.x do inc(i);
                while x.x < a[j].x do dec(j);
                if i <= j then begin
                t := a[i]; a[i] := a[j]; a[j] := t;
                inc(i); dec(j);
                end;
        until i > j;
        if l < j then sort(l, j);
        if i < h then sort(i, h);
end;

procedure init;
var
        i : longint;
begin
        randomize;
        sort(1, n);
end;

function dist(i, j : longint) : real;
begin
        exit(sqrt(sqr(a[i].x - a[j].x) + sqr(a[i].y - a[j].y)));
end;

function min(x, y : real) : real;
begin
        if x < y then exit(x) else exit(y);
end;

procedure merge(l, m, h : longint);
var
        i, j, k, p : longint;
begin
        i := l; j := m + 1; k := 0;
        while (i <= m) and (j <= h) do
        begin
                inc(k);
                if a[b[i]].y < a[b[j]].y then begin
                c[k] := b[i]; inc(i);
                end else begin
                c[k] := b[j]; inc(j);
                end;
        end;
        if i <= m then
                for p := i to m do begin inc(k); c[k] := b[p]; end
        else
                for p := j to h do begin inc(k); c[k] := b[p]; end;
        move(c[1], b[l], k*sizeof(b[1]));
end;

function minDist(l, h : longint) : real;
var
        i, j, k, m : longint;
        d : real;
begin
        if l >= h then exit(10e10);
        m := (l + h) div 2;
        d := min(minDist(l, m), minDist(m + 1, h));
        merge(l, m, h);
        j := 0;
        for i := l to h do
                if (abs(a[b[i]].x - a[m].x) < d) then begin
                inc(j);
                c[j] := b[i];
                end;
        for i := 1 to j - 1 do
        begin
                k := i + 1;
                while (k <= j) and (abs(a[c[i]].y - a[c[k]].y) < d) and (c[i] <> c[k]) do
                begin
                        di := dist(c[i], c[k]);
                        if di < d then
                        d := di;
                        inc(k);
                end;
        end;
        exit(d);
end;

procedure output;
var     f:text;
begin
        assign(f, fo);rewrite(f);
        write(f,minDist(1, n):0:3);
        close(f);
end;

begin
  readInput;
  init;
  output;
end.
