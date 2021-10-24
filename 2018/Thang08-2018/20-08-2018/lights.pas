const   ginp='lights.inp';
        gout='lights.out';
        maxch=1 shl 18-1;
        oo=trunc(1e6);

type    save=record x:int64;d:longint;end;

var     n,m,mch1,mch2,res:longint;
        head:array[0..35] of longint;
        link,y:array[-600..600] of longint;
        a:array[0..maxch] of save;

procedure add(i,u,v:longint);
begin
        y[i]:=v;
        link[i]:=head[u];
        head[u]:=i;
end;

procedure enter;
var     i,u,v:longint;
        d:array[0..35,0..35] of boolean;
begin
        readln(n,m);
        fillchar(d,sizeof(d),true);
        for i:=1 to m do
        begin
                readln(u,v);

                // nhieu canh bang nhau tinh 1 lan
                {if (d[u,v]) then
                begin
                        add(i,u,v);
                        add(-i,v,u);
                end;
                d[u,v]:=false; d[v,u]:=false; }
                add(i,u,v);
                add(-i,v,u);
        end;
        m:=n div 2;
        mch1:=1 shl m-1;
        mch2:=1 shl (n-m)-1;
end;

function getb(x:int64;k:longint):longint;
begin
        getb:=x shr (k-1) and int64(1);
end;

procedure daob(var x:int64;k:longint);
var     t:longint;
begin
        t:=getb(x,k);
        if t=0 then x:=x or (int64(1) shl (k-1))
        else x:=x and (not (int64(1) shl (k-1)));
end;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure sort(l,r:longint);
var     i,j:longint;
        t,tm:save;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].d<t.d)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].d>t.d)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sort(l,j);sort(i,r);
end;

procedure caculator;
var     i,u,x:longint;
begin
        for x:=0 to mch2 do
        begin
                a[x].x:=0;a[x].d:=0;
                for u:=1 to n-m do
                        if getb(int64(x),u)=1 then
                        begin
                                inc(a[x].d);
                                daob(a[x].x,u+m);
                                i:=head[u+m];
                                while i<>0 do
                                begin
                                        daob(a[x].x,y[i]);
                                        i:=link[i];
                                end;
                        end;
        end;
end;

function cnp(x:int64):longint;
var     left,right,mid:longint;
begin
        if (x<a[0].x) or (x>a[mch2].x) then exit(oo);
        left:=0;right:=mch2;
        while left<right do
        begin
                mid:=(left+right) shr 1;
                if a[mid].x>=x then right:=mid else left:=mid+1;
        end;
        if a[left].x=x then exit(a[left].d) else exit(oo);
end;

procedure findres;
var     ch,u,cou,i:longint;
        x:int64;
begin
        for ch:=0 to mch1 do
        begin
                x:=0;cou:=0;
                for u:=1 to m do
                        if getb(int64(ch),u)=1 then
                        begin
                                inc(cou);
                                daob(x,u);
                                i:=head[u];
                                while i<>0 do
                                begin
                                        daob(x,y[i]);
                                        i:=link[i];
                                end;
                        end;
                for u:=1 to n do daob(x,u);
                res:=min(res,cou+cnp(x));
        end;
end;

procedure process;
var     i:longint;
begin
        if n=1 then
        begin
                write(1);exit;
        end else res:=oo;
        caculator;
        sort(1,mch2);
        findres;

        writeln(res);
        //for i:=0 to mch2 do writeln(a[i].x, ' ', a[i].d);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
