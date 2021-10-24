const   ginp='clis.inp';
        gout='clis.out';
        oo=trunc(1e9)+100;

var     gi,go:text;
        n,l,r,vtd:longint;
        a:array[0..200010] of longint;

procedure input;
var     i:longint;
begin
        readln(gi,n);
        vtd:=0;
        for i:=1 to n do read(gi,a[i]);
        a[0]:=a[n];
        for i:=1 to n do
                if (a[i]<a[i-1]) and (vtd=0) then vtd:=i;
        for i:=1 to vtd-1 do a[n+i]:=a[i];
end;

procedure process;
var     i,left:longint;
begin
        i:=vtd;
        repeat
                left:=i;
                a[i-1]:=-oo;
                while (a[i]>=a[i-1]) and (i<=n+vtd-1) do inc(i);
                if i-left+1>r-l then
                begin
                        r:=i-1;l:=left;
                end;
        until i>n+vtd-1;
        l:=l mod n; if l=0 then l:=n;
        r:=r mod n; if r=0 then r:=n;
        write(go,l,' ',r);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        if vtd=0 then write(go,1,' ',n)
        else process;
        close(gi);close(go);
end.


