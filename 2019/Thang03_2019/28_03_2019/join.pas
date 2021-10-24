const
        tfi     =       'join.inp';
        tfo     =       'join.out';
        nmax    =       151;
type
        arr1    =       array[0..nmax] of longint;
var
        fi,fo:text;
        n,m,dem,f,r,x,res,chan,le:longint;
        kq:array[0..nmax,0..nmax,0..1] of longint;
        g:array[0..nmax,0..nmax,0..1] of boolean;
        c:array[0..nmax,0..nmax] of longint;
        qu,sl:array[0..nmax] of longint;
        free:array[0..nmax] of boolean;
procedure nhap;
var i,j,u,v:longint;
begin
        assign(fi,tfi);reset(fi);
          read(fi,n,m);
          for i:=1 to m do
            begin
              read(fi,u,v);
              c[u,v]:=1;
              c[v,u]:=1;
            end;
        close(fi);
end;
procedure khoitao;
var i,j:longint;
begin
        for i:=1 to n do
          free[i]:=true;
end;
procedure push(i:longint);
begin
        inc(r);
        qu[r]:=i;
end;
function pop:longint;
begin
        pop:=qu[f];
        inc(f);
end;
procedure BFS(i:longint);
var u,j,v:longint;
begin
        f:=1;
        r:=0;
        push(i);
        free[i]:=false;
        while f<=r do
          begin
            x:=pop;
            for u:=1 to n do
              if (free[u])and(c[x,u]=1) then
                begin
                  free[u]:=false;
                  push(u);
                end;
          end;
        sl[res]:=r;
        dem:=dem+(r*(r-1) div 2);
        for u:=1 to r-1 do
          for v:=u+1 to r do
            if c[qu[u],qu[v]]=1 then dec(dem);
end;
procedure xuly;
var i,j:longint;
begin
        for i:=1 to n do
          if free[i] then
            begin
              inc(res);
              BFS(i);
            end;
        for i:=1 to res do
          if sl[i] mod 2=0 then inc(chan)
          else inc(le);
end;
function xl(i,j,k:longint):boolean;
var u,v:longint;
begin
        if i+j=1 then exit(false);

        if kq[i,j,k]=1 then exit(g[i,j,k]);

        xl:=false;

        if i>=2 then
         if not xl(i-1,j,1-k) then
           xl:=true;

        if j>=2 then
         if not xl(i+1,j-2,k) then
           xl:=true;

        if (i>=1)and(j>=1) then
          if not xl(i-1,j,1-k) then
            xl:=true;

        if k=1 then
          if not xl(i,j,0) then
          xl:=true;

        g[i,j,k]:=xl;
        kq[i,j,k]:=1;
end;
procedure perfect;
var i,j:longint;
ok:boolean;
begin
        ok:=xl(chan,le,dem mod 2);
        if ok=true then writeln(fo,'Theodor')
        else writeln(fo,'Maxim');
end;
begin
        assign(fo,tfo);rewrite(fo);
        nhap;
        khoitao;
        xuly;
        perfect;
        close(fo);
end.
