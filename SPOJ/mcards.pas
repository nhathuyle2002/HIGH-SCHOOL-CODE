const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        n,c,res:longint;
        a,b:array[0..4001] of longint;

procedure input;
var     i,j:longint;
begin
        readln(gi,c,n);
        for i:=1 to n*c do readln(gi,a[n*c-i+1],b[n*c-i+1]);
end;

procedure process;
var     i,j:longint;
begin
        res:=0;
        for i:=1 to n*c do
                for j:=i+1 to n*c do
                        if (a[i]>a[j]) or ((a[i]=a[j]) and (b[i]>b[j])) then
                        begin
                                inc(res);
                                break;
                        end;
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.
