const   ginp='ss.inp';
        gout='ss.out';
        kk=round(1e9)+7;
        base=311;

var     gi,go:text;
        na,nb,ans:longint;
        a,b:ansistring;
        ha,hb,mub:array[0..10001] of int64;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,a);na:=length(a);
        read(gi,b);nb:=length(b);
end;

procedure process;
var     i,n:longint;
begin
        mub[0]:=1;ha[0]:=0;hb[0]:=0;
        if na<nb then n:=na else n:=nb;
        for i:=1 to n do
                mub[i]:=(mub[i-1]*base) mod kk;
        for i:=1 to na do
                ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        for i:=1 to nb do
                hb[i]:=(hb[i-1]*base+ord(b[i])) mod kk;
        for ans:=n downto 1 do
                if hb[ans]=(ha[na]-ha[na-ans]*mub[ans]+kk*kk) mod kk then exit;
        ans:=0;
end;

procedure output;
begin
        write(go,na+nb-ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.
