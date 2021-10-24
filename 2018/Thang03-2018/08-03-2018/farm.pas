const   ginp='farm.inp';
        gout='farm.out';

var     gi,go:text;
        n,m,r,x0,y0,p,vtmin,vtmax:longint;
        min,max:real;
        d:array[1..4,0..500001] of boolean;
        x,y:array[0..21] of longint;

procedure input;
var     i:Longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,r)
        readln(gi,x0,y0);
end;

procedure output;
begin
        close(gi);close(go);
end;

function hsg(x1,y1:longint):real;
var     dx,dy:longint;
begin
        dx:=x0-x1;
        dy:=y0-y1;
        if (dx=0) and (dy=0) then
        begin
                write(go,0);
                output;
                halt;
        end;
        hsg:=dx/sqrt(dx*dx+dy*dy);
end;

procedure process;
var     i:longint;
        tmp:real;
begin
        fillchar(d,sizeof(d),true);
        for i:=1 to r do
        begin
                readln(gi,p);
                vtmin:=0;vtmax:=0;
                min:=1;max:=-1;
                for i:=1 to p do
                begin
                        readln(gi,x[i],y[i]);
                        tmp:=hsg(x[i],y[i]);
                        if tmp<min then
                        begin
                                min:=tmp;
                                vtmin:=i;
                        end;
                        if tmp>max then
                        begin
                                max:=tmp;
                                vtmax:=i;
                        end;
                end;
        end;
end;

begin
        input;
        process;
        output;
end.