const fi='ss.inp';
      fo='ss.out';
      maxn=100000;
var n:longint;
    f:array[0..maxn] of longint;
    kt:boolean;

procedure rf;
var i,t:longint;
begin
     assign(input,fi);
     reset(input);
     readln(n);
     f[0]:=0;
     kt:=true;
     for i:=1 to n do
     begin
          read(t);
          f[i]:=f[i-1]+t;
          if f[i]<=0 then kt:=false;
          if (i=n) or (i=1) then kt:=kt and (t>0);
     end;
     close(input);
end;

procedure sort(l,r:longint);
var i,j,x,y:longint;
begin
     i:=l; j:=r; x:=f[(i+j) div 2];
     repeat
           while f[i]<x do inc(i);
           while f[j]>x do dec(j);
           if i<=j then
           begin
                y:=f[i]; f[i]:=f[j]; f[j]:=y;
                inc(i); dec(j);
           end;
     until i>j;
     if i<r then sort(i,r);
     if l<j then sort(l,j);
end;

procedure wf;
var i:longint;
begin
     assign(output,fo);
     rewrite(output);
     if kt then
     begin
          sort(1,n);
          for i:=1 to n do write(f[i]-f[i-1],' ');
     end
     else write(-1);
     close(output);
end;

begin
     rf;
     wf;
end.
