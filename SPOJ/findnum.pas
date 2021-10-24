const   ginp='ss.inp';
        gout='ss.out';
        ts:array[1..10] of longint =(2,3,5,7,11,13,17,19,23,29);

var     gi,go:text;
        n,gt:longint;
        a,d,u:array[0..20] of longint;
        res:qword;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=u[random(r-l+1)+l];
        repeat
                while u[i]>t do inc(i);
                while u[j]<t do dec(j);
                if i<=j then
                begin
                        tm:=u[i];u[i]:=u[j];u[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure dfs(i:longint);
var     j,k:longint;
        tm:qword;
begin
        if i=n+1 then
        begin
                for j:=1 to 10 do u[j]:=1;
                for j:=1 to n do u[d[j]]:=u[d[j]]*a[j];
                sort(1,n);
                tm:=1;
                for j:=1 to n do
                begin
                        if u[j]=1 then break;
                        for k:=1 to u[j]-1 do
                        begin
                                tm:=tm*ts[j];
                                if tm<=res then exit;
                        end;
                end;
                if tm<res then res:=tm;
                exit;
        end;
        for j:=1 to n do
        begin
                d[i]:=j;
                dfs(i+1);
        end;
end;

procedure main;
var     i:longint;
begin
        readln(gi,gt);
        i:=2;n:=0;
        while i<=gt do
        begin
                if gt mod i=0 then
                begin
                        inc(n);a[n]:=i;
                        gt:=gt div i;
                end
                else inc(i);
        end;
        res:=2*trunc(1e18);
        dfs(1);
        write(go,res);
end;

begin
        assign(gi,ginp);reset(gi);
        assign(go,gout);rewrite(go);
        main;
        close(gi);close(go);
end.
