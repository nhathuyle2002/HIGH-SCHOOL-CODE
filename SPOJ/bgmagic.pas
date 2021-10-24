const   ginp='ss.inp';
        gout='ss.out';

var     gi,go:text;
        m,n:longint;
        ans:int64;
        a:array[0..5001,0..5001] of int64;

procedure input;
var     i,j:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,m,n);
        for i:=1 to m do
        begin
                for j:=1 to n do read(gi,a[i,j]);
                readln(gi);
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function check(x,y:int64):boolean;
begin
        if x mod 2=y mod 2 then exit(true) else exit(false);
end;

procedure process;
var     i,j:longint;
begin
        ans:=0;
        for i:=1 to m do
                for j:=1 to n do
                begin
                        if a[i,j]=0 then
                        begin
                                a[i,j]:=max(a[i-1,j],a[i,j-1])+1;
                                if (i>1) and (j>1) and (check(a[i,j],a[i-1,j-1])) then inc(a[i,j]);
                                if (i>1) and (j<n) and (check(a[i,j],a[i-1,j+1])) then inc(a[i,j]);
                        end;
                        if (j>1) and (a[i,j]<=a[i,j-1]) then ans:=-1;
                        if (i>1) and (a[i,j]<=a[i-1,j]) then ans:=-1;
                        if (i>1) and (j>1) and (check(a[i,j],a[i-1,j-1])) then ans:=-1;
                        if (i>1) and (j<n) and (check(a[i,j],a[i-1,j+1])) then ans:=-1;
                        if ans=-1 then exit;
                        ans:=ans+a[i,j];
                end;
end;

procedure output;
begin
        write(go,ans);
        close(gi);close(go);
end;

begin
        input;
        process;
        output;
end.






