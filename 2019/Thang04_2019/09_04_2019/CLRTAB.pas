const fi='CLRTAB.INP';
      fo='CLRTAB.OUT';
var   f,g:text;
      u,v,i,j,n,m,mi,test,pos,vt,r:longint;
      c:array[1..60]of longint;
      a,b:array[1..60,1..60]of longint;
      d:array[1..100000,1..4]of longint;
procedure trao(var a,b:longint);
var   t:longint;
begin
      t:=a; a:=b; b:=t;
end;
procedure call;
begin
      assign(f,fi); reset(f);
      assign(g,fo); rewrite(g);
      readln(f,test);
end;
procedure fill;
begin
      r:=0;
      fillchar(c,sizeof(c),0);
end;
procedure nhap;
begin
      readln(f,m,n);
      for i:=1 to m do
      for j:=1 to n do
            begin read(f,a[i,j]);
                  inc(c[a[i,j]]);
            end;
end;
procedure xuli;
begin
      for j:=1 to n do
      begin
            mi:=m*n+1;
            for i:=1 to n do
                  if (c[i]>0) and (c[i]<mi) then
                  begin mi:=c[i];
                        vt:=i;
                  end;
            if c[vt]<m then
                  begin
                        mi:=m*n+1;
                        for i:=1 to n do
                              if (c[i]>0) and (c[i]<mi) and (i<>vt) and (c[i]+c[vt]>=m) then
                              begin mi:=c[i];
                                    pos:=i;
                              end;
                        for i:=1 to c[vt] do b[i,j]:=vt;
                        for i:=c[vt]+1 to m do b[i,j]:=pos;
                        dec(c[pos],m-c[vt]);
                        c[vt]:=0;
                  end
            else  begin
                        for i:=1 to m do b[i,j]:=vt;
                        dec(c[vt],m);
                  end;
      end;
end;
procedure find;
begin
      while b[i,j]=a[i,j] do
            begin
                  inc(i);
                  if i>m then exit;
            end;
      for u:=1 to m do
      for v:=1 to n do
            if ((v>j) or ((v=j) and (u>i))) then
            if (a[u,v]=b[i,j]) and (a[i,j]<>a[u,v]) then
            begin
                  inc(r);
                  d[r,1]:=i; d[r,2]:=j; d[r,3]:=u; d[r,4]:=v;
                  trao(a[i,j],a[u,v]);
                  inc(i);
                  if (i>m) or (b[i,j]<>b[i-1,j]) then exit;
                  while (b[i,j]=a[i,j]) do
                        begin
                              inc(i);
                              if i>m then exit;
                        end;
            end;
end;
procedure run;
begin
      for j:=1 to n do
      begin
            i:=1;
            find;
            if i<=m then find;
      end;
end;
procedure xuat;
begin
      writeln(g,r);
      for i:=1 to r do
      begin
            for j:=1 to 4 do write(g,d[i,j],' ');
            writeln(g);
      end;
end;
begin
      call;
      while test>0 do
            begin
                  fill;
                  nhap;
                  xuli;
                  run;
                  xuat;
                  dec(test);
            end;
      close(f); close(g);
end.