const   ginp='festival.inp';
        gout='festival.out';

var     gi,go:text;
        n,m:longint;
        ans:int64;
        d:array[0..2001,0..1001] of boolean;

procedure input;
var     i,u,v:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,m);
        fillchar(d,sizeof(d),false);
        for i:=1 to m do
        begin
                readln(gi,u,v);
                d[u,v+n]:=true;
        end;
end;

procedure process;
var     i,j,k,dem:longint;
begin
        ans:=0;
        for i:=1 to n-1 do
                for j:=i+1 to n do
                begin
                        dem:=0;
                        for k:=n+1 to 2*n do
                                if (d[i,k]) and (d[j,k]) then inc(dem);
                        if dem>1 then ans:=ans+dem*(dem-1) div 2;
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.

