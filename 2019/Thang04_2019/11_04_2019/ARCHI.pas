const fi='ARCHI.INP';
      fo='ARCHI.OUT';
var   ax:array[1..4]of longint=(0,1,0,-1);
      ay:array[1..4]of longint=(1,0,-1,0);
      kt,bac:array[-1010..1010,-1010..1010]of byte;
      lk:array[-1010..1010,-1010..1010,1..4]of byte;
      dx,dy:array[1..6000100]of longint;
      i,n,a,b,c,d,x,y,l,r,tx,ty,kq, coul, couc:longint;
      found:boolean;
      f:text;
function min(a,b:longint):longint;
begin
      if a<b then exit(a);
      exit(b);
end;
function max(a,b:longint):longint;
begin
      if a>b then exit(a);
      exit(b);
end;
procedure nhap;
var   f:text;
begin
      assign(f,fi); reset(f);
      readln(f,n);
      for i:=1 to n do
            begin readln(f,a,b,c,d);
                  begin
                        for x:=min(a,c) to max(a,c) do
                        for y:=min(b,d) to max(b,d) do
                        begin
                              if y>min(b,d) then lk[x,y,3]:=1;
                              if y<max(b,d) then lk[x,y,1]:=1;
                              if x>min(a,c) then lk[x,y,4]:=1;
                              if x<max(a,c) then lk[x,y,2]:=1;
                              if ((x<>a) or (y<>b)) and ((x<>c) or (y<>d)) then inc(bac[x,y],2)
                              else inc(bac[x,y]);
                        end;
                  end;
            end;
      close(f);
end;
procedure bfs(x,y:longint);
var   i:longint;
begin
      dx[1]:=x; dy[1]:=y; l:=1; r:=1;
      kt[x,y]:=1;
      repeat
            x:=dx[l]; y:=dy[l]; inc(l);
            for i:=1 to 4 do
            if lk[x,y,i]=1 then
                  begin
                        tx:=x+ax[i]; ty:=y+ay[i];
                        if kt[tx,ty]=1 then continue;
                        kt[tx,ty]:=1;
                        if bac[tx,ty] mod 2=1 then
                              begin inc(kq); inc(coul);
                                    found:=true;
                              end;
                        inc(r);
                        dx[r]:=tx; dy[r]:=ty;
                  end;
      until l>r;
end;
procedure xuli;
begin
        assign(f,fo); rewrite(f);
      for x:=-1000 to 1000 do
      for y:=-1000 to 1000 do
            if (kt[x,y]=0) and (bac[x,y]>0) then
                  begin

                        found:=false;
                        if bac[x,y] mod 2=1 then
                              begin inc(kq); inc(coul);
                                    found:=true;
                              end;
                        bfs(x,y);
                        if not found then
                        begin
                                inc(kq,2);
                                inc(couc);
                                writeln(f, x, ' ', y);
                        end;
                  end;
end;
procedure xuat;
//var   f:text;
begin
      writeln(f,kq div 2);
      writeln(f, coul);
      writeln(f, couc);
      close(F);
end;
begin
      nhap;
      xuli;
      xuat;
end.
