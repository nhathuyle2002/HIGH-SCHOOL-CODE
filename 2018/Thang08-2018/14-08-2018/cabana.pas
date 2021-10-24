const   ginp='cabana.inp';
        gout='cabana.out';
        oo=trunc(1e9)+111;

type    point=record x,y:int64;id,idy:longint;end;

var     n,cou:longint;
        res:int64;
        v:array[0..50010] of longint;
        a:array[0..50010] of point;
        f:array[0..4*50010] of longint;

procedure sortx(l,r:longint);
var     i,j:longint;
        t,tm:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[random(r-l+1)+l];
        repeat
                while (a[i].x<t.x) or ((a[i].x=t.x) and (a[i].y<t.y)) do inc(i);
                while (a[j].x>t.x) or ((a[j].x=t.x) and (a[j].y>t.y)) do dec(j);
                if i<=j then
                begin
                        tm:=a[i];a[i]:=a[j];a[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sortx(l,j);sortx(i,r);
end;

procedure sorty(l,r:longint);
var     i,j,tm:longint;
        t:point;
begin
        if l>=r then exit;
        i:=l;j:=r;
        t:=a[v[random(r-l+1)+l]];
        repeat
                while (a[v[i]].y<t.y) or ((a[v[i]].y=t.y) and (a[v[i]].x<t.x)) do inc(i);
                while (a[v[j]].y>t.y) or ((a[v[j]].y=t.y) and (a[v[j]].x>t.x)) do dec(j);
                if i<=j then
                begin
                        tm:=v[i];v[i]:=v[j];v[j]:=tm;
                        inc(i);dec(j);
                end;
        until i>j;
        sorty(l,j);sorty(i,r);
end;

procedure enter;
var     i:longint;
begin
        readln(n);
        for i:=1 to n do readln(a[i].x,a[i].y);
        sortx(1,n);
        for i:=1 to n do v[i]:=i;
        sorty(1,n);
        cou:=0;a[0].y:=-oo;
        for i:=1 to n do
        begin
                if a[v[i]].y>a[v[i-1]].y then inc(cou);
                a[v[i]].id:=cou;
                if a[v[i]].y=a[v[i-1]].y then a[v[i]].idy:=v[i-1];
        end;
end;

function max(x,y:int64):int64;
begin
        if x>y then exit(x) else exit(y);
end;

function min(x,y:int64):int64;
begin
        if x<y then exit(x) else exit(y);
end;

procedure update(id,l,r,v:longint;k:int64);
var     m:longint;
begin
        if (l>v) or (v>r) then exit;
        if (l=v) and (v=r) then
        begin
                f[id]:=max(f[id],k);
                exit;
        end;
        m:=(l+r) shr 1;
        update(id shl 1,l,m,v,k);
        update(id shl 1+1,m+1,r,v,k);
        f[id]:=max(f[id shl 1],f[id shl 1+1]);
end;

function quece(id,l,r,d,c:longint):int64;
var     m:longint;
begin
        if (l>r) or (c<l) or (d>r) then exit(-oo);
        if (d<=l) and (r<=c) then exit(f[id]);
        m:=(l+r) shr 1;
        quece:=max(quece(id shl 1,l,m,d,c),quece(id shl 1+1,m+1,r,d,c));
end;

procedure process;
var     i1,i2,i3,i4:longint;
        tmp:int64;
begin
        for i1:=1 to 4*cou do f[i1]:=-oo;
        for i1:=1 to n do
        begin
                i2:=i1-1;
                i3:=a[i1].idy;
                i4:=a[i2].idy;
                if (i2>0) and (i3>0) and (i4>0)
                and (a[i2].x=a[i1].x) and (a[i3].x=a[i4].x) then
                begin
                        tmp:=quece(1,1,cou,a[i2].id+1,a[i1].id-1);
                        if tmp<a[i3].x then res:=max(res,(a[i1].x-a[i3].x)*(a[i1].y-a[i2].y));
                end;
                update(1,1,cou,a[i1].id,a[i1].x);
        end;
        write(res);
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
