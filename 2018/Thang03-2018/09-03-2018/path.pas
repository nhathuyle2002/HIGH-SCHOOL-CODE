const   ginp='path.inp';
        gout='path.out';
        di:array[1..4] of longint =(-1,0,0,1);
        dj:array[1..4] of longint =(0,-1,1,0);

var     gi,go:text;
        n,m,dtp,min:longint;
        a:array[0..100,0..100] of char;
        bd:array[0..1000000] of longint;
        lt:array[0..100,0..100] of longint;
        d:array[0..100,0..100] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function cdt(i,j:longint):boolean;
begin
        if d[i,j]=false then exit(false);
        if (i<=0) or (j<=0) or (i>m) or (j>n) then exit(false);
        exit(true);
end;

procedure dfs(i,j:longint);
var     k:longint;
begin
        lt[i,j]:=dtp;
        d[i,j]:=false;
        for k:=1 to 4 do
                if cdt(i+di[k],j+dj[k]) and (a[i+di[k],j+dj[k]]='X') then dfs(i+di[k],j+dj[k]);
end;

procedure bfs(i0,j0:longint);
var     l,r,k,i1,j1:longint;
        qi,qj:array[0..1000000] of longint;
begin
        fillchar(bd,sizeof(bd),0);
        fillchar(d,sizeof(d),true);
        l:=0;r:=1;
        qi[1]:=i0;qj[1]:=j0;
        d[i0,j0]:=false;
        repeat
                inc(l);
                for k:=1 to 4 do
                begin
                        i1:=qi[l]+di[k];
                        j1:=qj[l]+dj[k];
                        if cdt(i1,j1) then
                        begin
                                d[i1,j1]:=false;
                                inc(r);
                                qi[r]:=i1;
                                qj[r]:=j1;
                                bd[r]:=bd[l]+1;
                                if (lt[i1,j1]<>lt[i0,j0]) and (lt[i1,j1]<>0) then
                                begin
                                        if bd[r]-1<min then min:=bd[r]-1;
                                        exit;
                                end;
                        end;
                end;
        until l>r;
end;

procedure process;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),true);
        for i:=1 to m do
                for j:=1 to n do
                        if (d[i,j]) and (a[i,j]='X') then
                        begin
                                inc(dtp);
                                dfs(i,j);
                        end;
        min:=maxlongint;
        for i:=1 to m do
                for j:=1 to n do
                        if lt[i,j]<>0 then bfs(i,j);
end;

procedure output;
begin
        write(go,min);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.












