uses math;
const
  FINP='ss.inp';
  FOUT='ss.out';
  MAXN=100111;
  oo=1000111000111000111;
var
  f1,f2:text;
  n:int64;
  hsize,a,b,c:longint;
  d:array[0..MAXN] of int64;
  h,hpos:array[0..MAXN] of longint;
procedure openF;
begin
  assign(f1,FINP); reset(f1);
  assign(f2,FOUT); rewrite(f2);
end;
procedure closeF;
begin
  close(f1); close(f2);
end;
procedure swap(var a,b:longint); inline;
var temp:longint;
begin temp:=a; a:=b; b:=temp; end;

procedure inp;
begin
  read(f1,n);
  read(f1,a,b,c);
  if a>b then swap(a,b);
  if a>c then swap(a,c);
end;
procedure downHeap(i:longint);
var
  j:longint;
begin
  j:=i<<1;
  while (j<=hsize) do
    begin
      if (j<hsize) and (d[h[j+1]]<d[h[j]]) then inc(j);
      if (d[h[j]]<d[h[i]]) then
        begin
          swap(hpos[h[i]],hpos[h[j]]);
          swap(h[i],h[j]);
        end;
      i:=j; j:=i<<1;
    end;
end;
procedure upHeap(i:longint);
var
  j:longint;
begin
  j:=i>>1;
  while (i>1) and (d[h[i]]<d[h[j]]) do
    begin
      swap(hpos[h[i]],hpos[h[j]]);
      swap(h[i],h[j]);
      i:=j; j:=i>>1;
    end;
end;
procedure push(u:longint);
begin
  inc(hsize); h[hsize]:=u; hpos[u]:=hsize;
  upHeap(hsize);
end;
procedure pop(var u:longint);
begin
  u:=h[1]; hpos[u]:=0;
  swap(h[1],h[hsize]); hpos[h[1]]:=1;
  dec(hsize);
  downHeap(1);
end;
procedure solve;
var
  u,v:longint;
begin
  for u:=0 to a-1 do d[u]:=oo;
  d[1 mod a]:=1; push(1 mod a);
  while (hsize>0) do
    begin
      pop(u);
      v:=(u+b) mod a;
      if d[v]>d[u]+b then
        begin
          d[v]:=d[u]+b;
          if hpos[v]=0 then push(v)
          else upHeap(hpos[v]);
        end;
      v:=(u+c) mod a;
      if d[v]>d[u]+c then
        begin
          d[v]:=d[u]+c;
          if hpos[v]=0 then push(v)
          else upHeap(hpos[v]);
        end;
    end;
end;
procedure ans;
var
  u:longint;
  count,ln:int64;
begin
  count:=0;
  for u:=0 to a-1 do
    begin
      ln:=(n div a)*a+u;
      if ln>n then ln-=a else if ln+a<=n then ln+=a;
      if ln>=d[u] then count+=(ln-d[u]) div a+1;
    end;
  if count=0 then count:=1;
  writeln(f2,count);
end;
begin
  openF;
  inp;
  solve;
  ans;
  closeF;
end.

