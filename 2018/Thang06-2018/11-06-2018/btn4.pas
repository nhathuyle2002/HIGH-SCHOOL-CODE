const   ginp='bnt4.inp';
        gout='btn4.out';
        maxn=300010;
        oo=trunc(1e8);

var     gi,go:text;
        a:ansistring;
        n,sum,res:longint;
        mi,ma,s:array[0..4*maxn] of longint;
        dd:array[0..maxn*5] of boolean;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

function max(x,y:longint):longint;
begin
        if x>y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m,tm,c1,c2:longint;
begin
        if (l=r) then
        begin
                if a[l]='(' then tm:=1 else tm:=-1;
                s[id]:=tm;mi[id]:=tm;ma[id]:=tm;
                exit;
        end;
        m:=(l+r) shr 1;
        c1:=id shl 1;c2:=c1+1;
        build(c1,l,m);
        build(c2,m+1,r);
        s[id]:=s[c1]+s[c2];
        mi[id]:=min(mi[c1],mi[c2]+s[c1]);
        ma[id]:=max(ma[c1],ma[c2]+s[c1]);
end;

procedure capnhat(id:longint);
var     tm:longint;
begin
        if dd[id]=true then exit;
        dd[id shl 1]:=not dd[id shl 1];
        dd[id shl 1+1]:=not dd[id shl 1+1];
        dd[id]:=true;s[id]:=-s[id];
        tm:=ma[id];ma[id]:=mi[id];mi[id]:=tm;
end;

procedure update(id,l,r,d,c:longint);
var     c1,c2,m:longint;
begin
        capnhat(id);
        if (l>c) or (r<d) then exit;
        if (d<=l) and (c<=r) then
        begin
                dd[id]:=false;capnhat(id);
                exit;
        end;
        m:=(l+r) shr 1;
        c1:=id shl 1;c2:=id shl 1+1;
        update(c1,l,m,d,c);
        update(c2,m+1,r,d,c);
        s[id]:=s[c1]+s[c2];
        mi[id]:=min(mi[c1],ma[c2]+s[c1]);
        ma[id]:=max(ma[c1],ma[c2]+s[c1]);
end;

procedure quece(id,l,r,d,c:longint);
var     m:longint;
begin
        capnhat(id);
        if (l>c) or (r<d) then exit;
        if (d<=l) and (r<=c) then
        begin
                res:=min(res,sum+mi[id]);
                sum:=sum+s[id];
                exit;
        end;
        m:=(l+r) shr 1;
        quece(id shl 1,l,m,d,c);
        quece(id shl 1+1,m+1,r,d,c);
end;

procedure input;
begin
        readln(gi,a);
        n:=length(a);
        build(1,1,n);
        fillchar(dd,sizeof(dd),true);
end;

procedure process;
var     q,d,c,k,i:longint;
begin
        readln(gi,q);
        for i:=1 to q do
        begin
                readln(gi,k,d,c);
                if k=1 then update(1,1,n,d,c) else
                begin
                        sum:=0;res:=oo;
                        quece(1,1,n,d,c);
                        if (sum=0) and (res>=0) then writeln(go,1)
                        else writeln(go,-1);
                end;
        end;
end;

begin
        assign(gi,ginp);assign(go,gout);
        reset(gi);rewrite(go);
        input;
        process;
        close(gi);close(go);
end.


















