const   ginp='lapphuong.inp';
        gout='lapphuong.out';

var     gi,go:text;
        n,dem:int64;
        nn:longint;
        u:array[0..1000000] of int64;

procedure output;
begin
        write(go,dem);
        close(gi);close(go);
        halt;
end;

procedure input;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        read(gi,n);
        if n mod 3<>0 then output;
        n:=n div 3;
end;

procedure uoc;
var     i:longint;
begin
        for i:=1 to trunc(sqrt(n)) do
                if n mod i=0 then
                begin
                        inc(nn);
                        u[nn]:=i;
                end;
end;

function cdt(x,y,z:int64):boolean;
var     tmp:int64;
begin
        if (x+y+z) mod 2=1 then exit(false);
        tmp:=(x+y+z) div 2;
        if tmp-x<=0 then exit(false);
        if tmp-y<=0 then exit(false);
        if tmp-z<=0 then exit(false);
        exit(true);
end;

procedure process;
var     i,j:longint;
        tmp,du:int64;
begin
        for i:=1 to nn do
                for j:=i to nn do
                begin
                        du:=n mod (u[i]*u[j]);
                        tmp:=n div (u[i]*u[j]);
                        if (du=0) and (tmp>=u[j]) then
                                if cdt(u[i],u[j],tmp) then
                                begin
                                        if (u[i]=u[j]) and (u[j]=tmp) then inc(dem);
                                        if ((u[i]=u[j]) and (u[j]<>tmp)) or ((u[j]=tmp) and (u[j]<>u[i])) then dem:=dem+3;
                                        if (u[i]<>u[j]) and (u[i]<>tmp) and (tmp<>u[i]) then  dem:=dem+6;
                                end;
                end;
end;

begin
        input;
        uoc;
        process;
        output;
end.












