const   ginp='swindow.inp';
        gout='swindow.out';
        maxn=1000010;
        kk=round(1e9)+7;
        base=311;

var     gi,go:text;
        n,m,k,res:longint;
        a,b:ansistring;
        d:array[0..maxn] of boolean;
        hb,pow:int64;
        ha:array[0..maxn] of int64;

procedure input;
begin
        readln(gi,a);n:=length(a);
        readln(gi,b);m:=length(b);
        read(gi,k);
        fillchar(d,sizeof(d),false);
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure process;
var     i,j:longint;
begin
        res:=0;
        pow:=1;
        for i:=1 to m do pow:=(pow*base) mod kk;
        for i:=1 to m do hb:=(hb*base+ord(b[i])) mod kk;
        for i:=1 to n do
                ha[i]:=(ha[i-1]*base+ord(a[i])) mod kk;
        for i:=n downto m do
                if hb=(ha[i]-ha[i-m]*pow+kk*kk) mod kk then
                begin
                        j:=i;
                        while (j<=n) and (j-k<=i-m) do
                                if d[j]=false then
                                begin
                                        d[j]:=true;
                                        if (j-k>=0) then inc(res);
                                        inc(j);
                                end else break;
                end;
        write(go,res);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
