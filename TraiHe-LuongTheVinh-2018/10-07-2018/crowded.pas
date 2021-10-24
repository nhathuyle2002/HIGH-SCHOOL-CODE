const   ginp='crowded.inp';
        gout='crowded.out';

var     n,k,l,r:longint;
        x,h,d:array[0..50010] of longint;
        ch1,ch2:array[0..50010] of boolean;

procedure swap(var xx,yy:longint); inline;
var     tm:longint;
begin
        tm:=xx;xx:=yy;yy:=tm;
end;

procedure sort(l,r:longint); inline;
var     i,j,t:longint;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=x[random(r-l+1)+l];
        repeat
                while x[i]<t do inc(i);
                while x[j]>t do dec(j);
                if i<=j then
                begin
                        swap(x[i],x[j]);
                        swap(h[i],h[j]);
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n,k);
        for i:=1 to n do readln(x[i],h[i]);
        sort(1,n);
end;

procedure pop1(td:longint); inline;
begin
        while (l<=r) and (x[d[l]]<td) do inc(l);
end;

procedure pop2(td:longint); inline;
begin
        while (l<=r) and (x[d[l]]>td) do inc(l);
end;

procedure push(i:longint); inline;
begin
        while (l<=r) and (h[d[r]]<=h[i]) do dec(r);
        inc(r);d[r]:=i;
end;

procedure process;
var     i,res:longint;
begin
        fillchar(ch1,sizeof(ch1),false);
        l:=1;r:=1;d[1]:=0;
        for i:=1 to n do
        begin
                pop1(x[i]-k);push(i);
                if h[d[l]]>=2*h[i] then ch1[i]:=true;
        end;
        fillchar(ch2,sizeof(ch2),false);
        l:=1;r:=1;d[1]:=0;
        for i:=n downto 1 do
        begin
                pop2(x[i]+k);push(i);
                if h[d[l]]>=2*h[i] then ch2[i]:=true;
        end;
        res:=0;
        for i:=1 to n do
                if (ch1[i]) and (ch2[i]) then inc(res);
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.




