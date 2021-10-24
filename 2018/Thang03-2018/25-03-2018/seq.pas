const   ginp='seq.inp';
        gout='seq.out';

var     gi,go:text;
        n,h,l,r:longint;
        ans:int64;
        a,sum:array[0..100001] of int64;
        d:array[0..100001] of longint;
        ok:array[0..100001] of boolean;

procedure input;
var     i:longint;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,n,h);
        for i:=1 to n do read(gi,a[i]);
end;

procedure create;
var     i:longint;
begin
        fillchar(ok,sizeof(ok),false);
        for i:=1 to n do
                if a[i]=1 then ok[i]:=true;
        for i:=1 to n do
                a[i]:=a[i]+n-i+1;
        for i:=1 to n do sum[i]:=sum[i-1]+a[i];
end;

function empty:boolean;
begin
        if l>r then exit(false) else exit(true);
end;

procedure push(i:longint);
begin
        while (empty) and (a[d[r]]<a[i]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure pop(i:longint);
begin
        while (empty) and (d[l]<i) do inc(l);
end;

procedure deque;
var     i:longint;
        tmp:int64;
begin
        ans:=10000000000000000;
        l:=0;r:=0;d[0]:=0;
        for i:=1 to n do
        begin
                if i>=h then
                begin
                        pop(i-h+1);
                        push(i);
                        tmp:=a[d[l]]*h-sum[i]+sum[i-h];
                        if (tmp<ans) and (a[d[l]]=a[i-h+1]) and (ok[i-h+1]) then ans:=tmp;
                end
                else push(i);
        end;
end;

procedure output;
begin
        if ans=10000000000000000 then write(go,-1) else write(go,ans);
        close(gi);close(go);
end;


begin
        input;
        create;
        deque;
        output;
end.













