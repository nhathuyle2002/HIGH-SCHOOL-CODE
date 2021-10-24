const   ginp='ss.inp';
        gout='ss.out';
        di:array[1..4] of longint =(-1,0,0,1);
        dj:array[1..4] of longint =(0,-1,1,0);

var     gi,go:text;
        m,n,maxh,res:longint;
        h:array[0..101,0..101] of longint;
        d,dd:array[0..101,0..101] of boolean;

function cdt(i,j,k:longint):boolean;
begin
        if (i<0) or (j<0) or (i>m+1) or (j>n+1) then exit(false);
        if (h[i,j]>k) or (dd[i,j]=false) then exit(false);
        exit(true);
end;

procedure dfs(i,j,k:longint);
var     kk,i0,j0:longint;
begin
        if d[i,j] then res:=res+k-h[i,j];
        d[i,j]:=false;
        dd[i,j]:=false;
        for kk:=1 to 4 do
        begin
                i0:=i+di[kk];
                j0:=j+dj[kk];
                if cdt(i0,j0,k) then dfs(i0,j0,k);
        end;
end;

procedure main;
var     i,j:longint;
begin
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(gi,h[i,j]);
                        if maxh<h[i,j] then maxh:=h[i,j];
                end;
                readln(gi);
        end;
        res:=0;
        fillchar(d,sizeof(d),true);
        for i:=0 to maxh do
        begin
                fillchar(dd,sizeof(dd),true);
                dfs(0,0,i);
        end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        main;
        close(gi);close(go);
end.
