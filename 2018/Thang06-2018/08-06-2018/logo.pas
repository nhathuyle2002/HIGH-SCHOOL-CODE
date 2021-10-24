const   ginp='logo.inp';
        gout='logo.out';
        hs=pi/180;

var     gi,go:text;
        n,st:longint;
        res:real;
        a,b:array[0..1001] of longint;

procedure chuanhoa(i:longint;s:string);
var     k:longint;
begin
        s:=s+' ';k:=1;
        while s[k]=' ' do inc(k);
        a[i]:=ord(s[k]);
        while s[k]<>' ' do inc(k);
        while s[k]=' ' do inc(k);
        b[i]:=0;
        while s[k]<>' ' do
        begin
                b[i]:=b[i]*10+ord(s[k])-48;
                inc(k);
        end;
end;

function cn(x:longint):longint;
begin
        if x>180 then exit(x-360);
        if x<-180 then exit(x+360);
        exit(x);
end;

procedure main;
var     i,tm:longint;
        goc:longint;
        s:string;
        tdx,tdy:real;
begin
        res:=0;
        readln(gi,n);
        for i:=1 to n do
        begin
                readln(gi,s);
                chuanhoa(i,s);
        end;
        goc:=0;tdx:=0;tdy:=0;
        for i:=1 to n do
        begin
                if a[i]=ord('l') then goc:=cn(goc+b[i]);
                if a[i]=ord('r') then goc:=cn(goc-b[i]);
                if a[i]=ord('f') then
                begin
                        tdx:=tdx+b[i]*cos(goc*hs);
                        tdy:=tdy+b[i]*sin(goc*hs);
                end;
                if a[i]=ord('b') then
                begin
                        tdx:=tdx-b[i]*cos(goc*hs);
                        tdy:=tdy-b[i]*sin(goc*hs);
                end;
        end;
        res:=sqrt(tdx*tdx+tdy*tdy);
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        while st>0 do
        begin
                main;
                writeln(go,res:0:0);
                dec(st);
        end;
        close(gi);close(go);
end.
