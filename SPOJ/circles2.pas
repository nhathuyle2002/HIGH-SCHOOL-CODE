const   ginp='circles.inp';
        gout='circles.out';

var     gi,go:text;
        xmin,xmax,n:Longint;
        a,f:array[-300..300,-300..300] of longint;

function max(x,y:Longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure input;
var     i,c,r:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        xmax:=-maxlongint;
        xmin:=maxlongint;
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,c,r);
                xmax:=max(xmax,c+r);
                xmin:=min(xmin,c-r);
                inc(a[c-r,c+r]);
        end;
end;

procedure process;
var     i,j,res,k:longint;
begin
        for res:=2 to xmax-xmin do
                for i:=xmin to xmax-res do
                begin
                        j:=i+res;
                        for k:=i+1 to j-1 do
                                f[i,j]:=max(f[i,j],a[i,j]+f[i,k]+f[k,j]);
                end;
end;

procedure output;
begin
        write(go,n-f[xmin,xmax]);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.









