const   ginp='del.inp';
        gout='del.out';
        maxk=round(1e18);

var     gi,go:text;
        n:longint;
        k,sum,q:qword;
        a:array[0..11] of qword;

function bcnn(x,y:qword):qword;
var     tm1,tm2,tm:qword;
begin
        if x>y then
        begin
                tm:=x;x:=y;y:=tm;
        end;
        tm1:=x;tm2:=y;
        while x<>0 do
        begin
                tm:=x;
                x:=y mod x;
                y:=tm;
        end;
        bcnn:=(tm1 div y)*tm2;
end;

procedure try(i,tt:longint;bc:qword);
var     j:longint;
begin
        if tt mod 2=1 then sum:=sum+q div bc
        else sum:=sum-q div bc;
        for j:=i+1 to n do try(j,tt+1,bcnn(bc,a[j]));
end;

procedure main;
var     i,st,t:longint;
        l,r:qword;
begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        readln(gi,st);
        for t:=1 to st do
        begin
                readln(gi,n,k);
                for i:=1 to n do read(gi,a[i]);readln(gi);
                l:=1;r:=maxk;
                while l<>r do
                begin
                        q:=(l+r) div 2;
                        sum:=0;
                        for i:=1 to n do try(i,1,a[i]);
                        if q-sum>=k then r:=q else l:=q+1;
                end;
                writeln(go,l);
        end;
        close(gi);close(go);
end;

begin
        main;
end.


