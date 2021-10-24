const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;
        base=311;

var     gi,go:text;
        na,nb,n,ans:longint;
        ha,pow,hb:array[0..1000001] of int64;
        a,b:ansistring;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,a);na:=length(a);
        read(gi,b);nb:=length(b);
        if na<nb then n:=na else n:=nb;
end;

procedure process;
var     i:longint;
begin
        hb[0]:=0;
        for i:=1 to nb do hb[i]:=(hb[i-1]*base+ord(b[i])) mod kk;
        ha[0]:=0;
        for i:=1 to na do ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        pow[0]:=1;
        for i:=1 to n do pow[i]:=(pow[i-1]*base) mod kk;
        ans:=0;
        for i:=1 to n do
                if hb[i]=(ha[na]-(ha[na-i]*pow[i])+kk*kk) mod kk then ans:=i;
end;

procedure output;
var     i:longint;
begin
        for i:=1 to na-ans do write(go,a[i]);
        write(go,b);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
