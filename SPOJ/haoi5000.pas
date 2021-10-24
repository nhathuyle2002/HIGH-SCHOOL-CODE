const   ginp='ss.inp';
        gout='ss.out';
        maxn=1000100;

var     gi,go:text;
        n,pt,ps:longint;
        d,ft,fs:array[0..2*maxn+1] of int64;

procedure input;
var     i,x,k:longint;
begin
        readln(gi,n,k);
        for i:=1 to k do
        begin
                read(gi,x);
                inc(d[x]);inc(d[x+n]);
        end;
end;

procedure process;
var     i,tmp,cou,ps,pt:longint;
        ou:array[0..maxn] of longint;
        tm1,tm2:int64;
begin
        pt:=(n-1) div 2+1;
        ps:=n div 2+1;
        tmp:=0;
        for i:=1 to n+ps do
        begin
                ft[i]:=ft[i-1]+tmp;
                tmp:=tmp+d[i];
                if i-pt>0 then
                if d[i-pt]<>0 then
                begin
                        tmp:=tmp-d[i-pt];
                        ft[i]:=ft[i]-d[i-pt]*pt;
                end;
        end;
        tmp:=0;
        for i:=2*n downto pt do
        begin
                fs[i]:=fs[i+1]+tmp;
                tmp:=tmp+d[i];
                if i+ps<=2*n then
                if d[i+ps]<>0 then
                begin
                        tmp:=tmp-d[i+ps];
                        fs[i]:=fs[i]-d[i+ps]*ps;
                end;
        end;
        cou:=1;ou[1]:=1;tm1:=ft[1+n]+fs[1+n];
        for i:=2 to n div 2 do
        begin
                tm2:=ft[i+n]+fs[i+n];
                if tm1>tm2 then
                begin
                        cou:=1;tm1:=tm2;
                        ou[1]:=i;
                end else
                if tm1=tm2 then
                begin
                        inc(cou);
                        ou[cou]:=i;
                end;
        end;
        for i:=n div 2+1 to n do
        begin
                tm2:=ft[i]+fs[i];
                if tm1>tm2 then
                begin
                        cou:=1;tm1:=tm2;
                        ou[1]:=i;
                end else
                if tm1=tm2 then
                begin
                        inc(cou);
                        ou[cou]:=i;
                end;
        end;
        writeln(go,tm1);
        writeln(go,cou);
        for i:=1 to cou do write(go,ou[i],' ');
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
