const   ginp='kmult.inp';
        gout='kmult.out';

var     gi,go:text;
        n,k:longint;
        a:array[0..10001] of longint;
        d:array[0..10001,0..101] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,k);
        for i:=1 to n do
        begin
                read(gi,a[i]);
                a[i]:=a[i] mod k;
        end;
end;

function du(x:longint):longint;
begin
        exit((x+k) mod k);
end;

procedure process;
var     i,j:longint;
begin
        fillchar(d,sizeof(d),false);
        d[1,du(a[1])]:=true;
        for i:=2 to n do
                for j:=0 to k-1 do
                        if d[i-1,j] then
                        begin
                                d[i,du(j+a[i])]:=true;
                                d[i,du(j-a[i])]:=true;
                        end;
end;

procedure output;
var     i,j,tm:longint;
        xu:array[0..10001] of longint;
begin
        if d[n,0]=false then write(go,0)
        else
        begin
                writeln(go,1);
                i:=n;j:=0;
                repeat
                        if d[i-1,du(j+a[i])] then
                        begin
                                tm:=1;
                                j:=du(j+a[i]);
                        end
                        else
                        begin
                                tm:=2;
                                j:=du(j-a[i]);
                        end;
                        dec(i);xu[i]:=tm;
                until i=1;
                for i:=1 to n-1 do
                        if xu[i]=2 then write(go,'+') else write(go,'-');
        end;
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.






