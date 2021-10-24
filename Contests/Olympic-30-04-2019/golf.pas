const   ginp='golf.inp';
        gout='golf.out';
        di:array[1..4] of longint=(1,-1,0,0);
        dj:array[1..4] of longint=(0,0,1,-1);

var     gi,go:text;
        n,m,xx,yy,mind:longint;
        a,h:array[0..501,0..501] of longint;
        d:array[0..501,0..501] of boolean;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,h[i,j]);
                readln(gi);
        end;
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
        for i:=1 to m do
                for j:=1 to n do
                        if a[i,j]=1 then
                        begin
                                xx:=i;
                                yy:=j;
                                exit;
                        end;
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function abs(x:longint):longint;
begin
        if x>=0 then exit(x) else exit(-x);
end;

function cdt(i,j,i0,j0:longint):boolean;
begin
        if (i0<1) or (i0>m) or (j0<1) or (j0>n) then exit(false);
        if (d[i0,j0]) and (abs(h[i,j]-h[i0,j0])<=mind) then exit(true);
        exit(false);
end;

procedure dfs(i,j:longint);
var     i0,j0,k:longint;
begin
        d[i,j]:=false;
        for k:=1 to 4 do
        begin
                i0:=di[k]+i;
                j0:=dj[k]+j;
                if cdt(i,j,i0,j0) then dfs(i0,j0);
        end;
end;

function check:boolean;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                        if (a[i,j]=1) and (d[i,j]) then exit(false);
        exit(true);
end;

procedure process;
var     i,j:longint;
        dau,cuoi:longint;
begin
        dau:=0;cuoi:=1000000000;
        while (dau<>cuoi) do
        begin
                fillchar(d,sizeof(d),true);
                mind:=(dau+cuoi) div 2;
                dfs(xx,yy);
                if check then cuoi:=mind else dau:=mind+1;
        end;
        mind:=dau;
end;

procedure output;
begin
        write(go,mind);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
