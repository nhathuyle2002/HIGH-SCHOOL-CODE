const fi='GAME2.inp';
      fo='GAME2.out';
      oo=trunc(1e7);
var   kq,i,n,x,v,ra,rb,rc,y,z,t:longint;
      s:array[0..100,0..100,0..100,0..100]of longint;
      a,b,c:array[1..110]of longint;
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
            begin read(f,x);
                  if x<>0 then begin inc(ra);
                                     a[ra]:=x;
                               end;
            end;
      for i:=1 to n do
            begin read(f,x);
                  if x<>0 then begin inc(rb);
                                     b[rb]:=x;
                               end;
            end;
      for i:=1 to n do
            begin read(f,x);
                  if x<>0 then begin inc(rc);
                                     c[rc]:=x;
                               end;
            end;
      close(f);
end;
procedure fill;
begin
      for x:=0 to ra do
      for y:=0 to rb do
      for z:=0 to rc do
      for t:=0 to n-ra do
            begin s[x,y,z,t]:=-oo;
                  if (x=0) and (y=0) and (z=0) and (t<=n-rb) and (t<=n-rc)
                        then s[x,y,z,t]:=0;
            end;
end;
procedure xuli;
begin
      for x:=0 to ra do
      for y:=0 to rb do
      for z:=0 to rc do
      for t:=0 to n-ra do
      if (x+t<=y+n-rb) and (x+t<=z+n-rc) and (x+t>=max(y,z)) then
      begin
            if (x>0) and (y>0) and (z>0) then
                  v:=s[x-1,y-1,z-1,t]+a[x]*b[y]*c[z]
            else v:=s[x,y,z,t];
            if (x>0) and (x-1+t>=max(y,z)) then
                  v:=max(v,s[x-1,y,z,t]);
            if (x>0) and (y>0) and (x-1+t>=z) then
                  v:=max(v,s[x-1,y-1,z,t]);
            if (x>0) and (z>0) and (x-1+t>=y) then
                  v:=max(v,s[x-1,y,z-1,t]);
            if t>0 then
                  begin
                        if (y>0) and (x+t-1>=z) then
                              v:=max(v,s[x,y-1,z,t-1]);
                        if (z>0) and (x+t-1>=y) then
                              v:=max(v,s[x,y,z-1,t-1]);
                        if (y>0) and (z>0) then v:=max(v,s[x,y-1,z-1,t-1]);
                  end;
            s[x,y,z,t]:=v;
      end;
      kq:=-oo;
      for t:=0 to n-ra do
            kq:=max(kq,s[ra,rb,rc,t]);
end;
procedure xuat;
var   f:text;
begin
      assign(f,fo); rewrite(f);
      write(f,kq);
      close(f);
end;
begin
      nhap;
      fill;
      xuli;
      xuat;
end.