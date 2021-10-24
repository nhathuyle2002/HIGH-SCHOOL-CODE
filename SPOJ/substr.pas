const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;
        base=311;

var     gi,go:text;
        na,nb:longint;
        hb,modb:int64;
        ha:array[0..1000001] of int64;
        a,b:ansistring;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,a);na:=length(a);
        read(gi,b);nb:=length(b);
end;

procedure process;
var     i:longint;
begin
        hb:=0;
        for i:=1 to nb do hb:=(hb*base+ord(b[i])) mod kk;
        ha[0]:=0;
        for i:=1 to na do ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        modb:=1;
        for i:=1 to nb do modb:=(modb*base) mod kk;
        for i:=nb to na do
                if hb=(ha[i]-(ha[i-nb]*modb) mod kk+kk*kk) mod kk then write(go,i-nb+1,' ');
end;

procedure output;
begin
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
