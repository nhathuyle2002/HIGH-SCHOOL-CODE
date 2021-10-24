const   ginp='bai2.inp';
        gout='bai2.out';
        di:array[1..8] of longint =(-1,-1,-1,0,0,1,1,1);
        dj:array[1..8] of longint =(-1,0,1,-1,1,-1,0,1);

var     gi,go:text;
        m,n,res:longint;
        h:array[0..1001,0..1001] of longint;
        d:array[0..1001,0..1001] of boolean;
        ok:boolean;

procedure input;
var     i,j:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,h[i,j]);
                readln(gi);
        end;
end;

function cdt(i,j:longint):boolean;
begin
        if (i<1) or (j<1) or (i>m) or (j>n) then exit(false);
        exit(true);
end;

procedure dfs(i,j:longint);
var     i0,j0,k:longint;
begin
        d[i,j]:=false;
        for k:=1 to 8 do
        begin
                i0:=i+di[k];
                j0:=j+dj[k];
                if cdt(i0,j0) then
                begin
                        if (h[i0,j0]=h[i,j]) and (d[i0,j0]) then dfs(i0,j0);
                        if h[i0,j0]>h[i,j] then ok:=false;
                end;
        end;
end;

procedure main;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),true);
        res:=0;
        for i:=1 to m do
                for j:=1 to n do
                        if d[i,j] then
                        begin
                                ok:=true;
                                dfs(i,j);
                                if ok then inc(res);
                        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        main;
        close(gi);close(go);
end.