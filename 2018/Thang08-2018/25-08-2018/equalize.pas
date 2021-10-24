const   ginp='equalize.inp';
        gout='equalize.out';
        maxg=10000000+1;

var     m,n,q,x,y,cou:longint;
        a,s:array[0..1010,0..1010] of longint;
        b:array[0..1000010] of longint;

procedure sort(l,r:longint);
var     i,j,t,tm:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=b[random(r-l+1)+l];
        repeat
                while b[i]<t do inc(i);
                while b[j]>t do dec(j);
                if i<=j then
                begin
                        tm:=b[i];b[i]:=b[j];b[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i,j:longint;
begin
        readln(m,n,q);
        for i:=1 to m do
        begin
                for j:=1 to n do
                begin
                        read(a[i,j]);
                        inc(cou);b[cou]:=a[i,j];
                end;
                readln;
        end;
        sort(1,cou);
        b[cou+1]:=maxg;
end;

function check(mid:longint):boolean;
var     i,j:longint;
begin
        for i:=1 to m do
                for j:=1 to n do
                begin
                        s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1];
                        if a[i,j]<mid then dec(s[i,j]) else inc(s[i,j]);
                        if (i>=x) and (j>=y) and (s[i,j]-s[i,j-y]-s[i-x,j]+s[i-x,j-y]>0) then exit(true);
                end;
        exit(false);
end;

procedure process;
var     t,l,r,mid:longint;
begin
        for t:=1 to q do
        begin
                readln(x,y);
                l:=0;r:=cou+1;
                while l<r do
                begin
                        mid:=(l+r) shr 1;
                        if check(b[mid]) then l:=mid+1 else r:=mid;
                end;
                writeln(b[l-1]);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.