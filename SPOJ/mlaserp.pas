
const dx:array[1..4] of shortint=(-1,0,1,0);
      dy:array[1..4] of shortint=(0,1,0,-1);
      maxn=110;
var n,m,re:longint;
    a:array[1..maxn,1..maxn] of char;
    d:array[1..maxn,1..maxn,1..4] of byte;
    s:array[0..1,0..1] of longint;
    q:array[1..1000000,0..3] of longint;

procedure rf;
var i,j,k:longint;
begin
     readln(n,m);
     k:=-1;
     for i:=1 to m do
     begin
          for j:=1 to n do
          begin
               read(a[i,j]);
               if a[i,j]='C' then
               begin
                    inc(k);
                    s[k,0]:=i; s[k,1]:=j;
               end;
          end;
          readln;
     end;
end;

function check(x,y:longint):Boolean;
begin
     check:=(x>0) and (y>0) and (x<=m) and (y<=n) and (a[x,y]<>'*');
end;

procedure pr;
var i,j,k,x,y,dir,x1,y1,num,t:longint;
begin
     fillchar(d,sizeof(d),0);
     x:=s[0,0]; y:=s[0,1];
     d[x,y,1]:=1;
     num:=4;
     for j:=1 to 4 do
     begin
          q[j,0]:=x; q[j,1]:=y;
          q[j,2]:=j; q[j,3]:=0;
          d[x,y,j]:=1;
     end;
     i:=1; re:=100000;
     repeat
           x:=q[i,0]; y:=q[i,1]; dir:=q[i,2];
           if (x=s[1,0]) and (y=s[1,1]) and (q[i,3]<re) then
              re:=q[i,3];
           for j:=1 to 4 do
           begin
                x1:=x+dx[j]; y1:=y+dy[j];
                if not check(x1,y1) then continue;
                if d[x1,y1,j]=0 then
                begin
                     inc(num);
                     q[num,0]:=x1; q[num,1]:=y1;
                     q[num,2]:=j; q[num,3]:=q[i,3];
                     if j<>dir then inc(q[num,3]);
                     d[x1,y1,j]:=q[num,3];
                end
                else
                begin
                     t:=q[i,3];
                     if j<>dir then inc(t);
                     if t<d[x1,y1,j] then
                     begin
                          inc(num);
                          q[num,0]:=x1; q[num,1]:=y1;
                          q[num,2]:=j; q[num,3]:=t;
                          d[x1,y1,j]:=t;
                     end;
                end;
           end;
           inc(i);
     until i>num;
end;

procedure wf;
begin
     write(re);
end;

begin
     rf;
     pr;
     wf;
end.
