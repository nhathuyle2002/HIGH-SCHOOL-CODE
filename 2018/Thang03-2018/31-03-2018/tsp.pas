const   ginp='tsp.inp';
        gout='tsp.out';

var     gi,go:text;
        n,dem:longint;
        res,ans,gtm:int64;
        w:array[0..21,0..21] of longint;
        d:array[0..21] of boolean;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n);
        gtm:=maxlongint;
        for i:=1 to n do
        begin
                for j:=1 to n do
                begin
                        read(gi,w[i,j]);
                        if w[i,j]=0 then w[i,j]:=maxlongint;
                        gtm:=min(gtm,w[i,j]);
                end;
        end;
        ans:=maxlongint;
        fillchar(d,sizeof(d),true);
end;

procedure try(u:longint);
var     i:longint;
begin
        if res+(n-dem)*gtm>=ans then exit;
        if dem=n-1 then
        begin
                ans:=min(ans,res+w[u,1]);
                exit;
        end;
        for i:=2 to n do
                if d[i] then
                begin
                        res:=res+w[u,i];
                        inc(dem);
                        d[i]:=false;
                        try(i);
                        dec(dem);
                        d[i]:=true;
                        res:=res-w[u,i];
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        try(1);
        output;
end.







