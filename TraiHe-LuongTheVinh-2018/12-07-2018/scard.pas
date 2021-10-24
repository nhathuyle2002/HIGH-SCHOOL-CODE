// ~~ Best ~~ //

const   ginp='scard.inp';
        gout='scard.out';

var     m,n,cou:longint;
        a,b,o:array[0..110] of int64;

function uc(a,b:int64):int64;
begin
        if b=0 then exit(a);
        uc:=uc(b,a mod b);
end;

function check(c,d:array of int64):boolean;
var     i,j:longint;
        tm:int64;
begin
        for i:=1 to m do
                for j:=1 to m do
                begin
                        tm:=uc(c[i],d[j]);
                        c[i]:=c[i] div tm;
                        d[j]:=d[j] div tm;
                end;
        for i:=1 to m do
                if d[i]>1 then exit(false);
        exit(true);
end;

procedure main;
var     i,j:longint;
begin
        readln(m,n);
        cou:=0;
        for i:=1 to m do read(a[i]);readln;
        for j:=1 to n do
        begin
                for i:=1 to m do read(b[i]);readln;
                if check(a,b) then
                begin
                        inc(cou);
                        o[cou]:=j;
                end;
        end;
        writeln(cou);
        for i:=1 to cou do write(o[i],' ');
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        main;
        close(input);close(output);
end.
