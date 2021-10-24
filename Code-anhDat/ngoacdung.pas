type    save=record g,dd:longint;d:boolean;end;

const   ginp='ngoac.inp';
        gout='ngoac.out';
        oo=trunc(1e9);

var     n,q:longint;
        s:ansistring;
        a:array[0..300010] of longint;
        d:array[0..300010] of boolean;
        f:array[0..4*300010] of save;

function min(x,y:longint):longint;
begin
        if x<y then exit(x) else exit(y);
end;

procedure build(id,l,r:longint);
var     m:longint;
begin
        if l=r then
        begin
                f[id].g:=a[l];
                f[id].d:=d[l];
                f[id].dd:=0;
                exit;
        end;
        m:=(l+r) shr 1;
        build(id shl 1,l,m);
        build((id shl 1)+1,m+1,r);
        f[id].g:=min(f[id shl 1].g,f[(id shl 1)+1].g);
        f[id].d:=f[id shl 1].d or f[(id shl 1)+1].d;
end;

procedure enter;
var     i:longint;
begin
        readln(n,q);
        readln(s);
        for i:=1 to n do
                if s[i]='(' then
                begin
                        a[i]:=a[i-1]+1;
                        d[i]:=false;
                end else
                begin
                        a[i]:=a[i-1]-1;
                        d[i]:=true;
                end;
        build(1,1,n);
end;

procedure cnt(id,l,r:longint);
var     il,ir:longint;
begin
        f[id].g:=f[id].g+f[id].dd;
        il:=id shl 1;ir:=il+1;
        if l<r then
        begin
                f[il].dd:=f[il].dd+f[id].dd;
                f[ir].dd:=f[ir].dd+f[id].dd;
        end;
        f[id].dd:=0;
end;

procedure upg(id,l,r,dd,cc,k:longint);
var     m:longint;
begin
        cnt(id,l,r);
        if (l>cc) or (r<dd) then exit;
        if (dd<=l) and (r<=cc) then
        begin
                f[id].dd:=k;
                cnt(id,l,r);
                exit;
        end;
        m:=(l+r) shr 1;
        upg(id shl 1,l,m,dd,cc,k);
        upg((id shl 1)+1,m+1,r,dd,cc,k);
        f[id].g:=min(f[id shl 1].g,f[(id shl 1)+1].g);
end;

function qg(id,l,r,dd,cc:longint):longint;
var     m:longint;
begin
        cnt(id,l,r);
        if (cc<l) or (r<dd) then exit(oo);
        if (dd<=l) and (r<=cc) then exit(f[id].g);
        m:=(l+r) shr 1;
        qg:=min(qg(id shl 1,l,m,dd,cc),qg((id shl 1)+1,m+1,r,dd,cc));
end;

procedure upd(id,l,r,v:longint;k:boolean);
var     m:longint;
begin
        if (l>v) or (r<v) then exit;
        if (l=v) and (v=r) then
        begin
                f[id].d:=k;
                exit;
        end;
        m:=(l+r) shr 1;
        upd(id shl 1,l,m,v,k);
        upd((id shl 1)+1,m+1,r,v,k);
        f[id].d:=f[id shl 1].d or f[(id shl 1)+1].d;
end;

function qd(id,l,r:longint):longint;
var     m:longint;
begin
        if l=r then exit(l);
        m:=(l+r) shr 1;
        if f[id shl 1].d then qd:=qd(id shl 1,l,m)
        else qd:=qd((id shl 1)+1,m+1,r);
end;

function cnpg:longint;
var     l,r,m:longint;
begin
        l:=1;r:=n;
        while l<r do
        begin
                m:=(l+r) shr 1;
                if qg(1,1,n,m,n)>=2 then r:=m else l:=m+1;
        end;
        cnpg:=l;
end;

procedure process;
var     i,v,vv:longint;
begin
        for i:=1 to q do
        begin
                readln(v);
                if d[v] then
                begin
                        upg(1,1,n,v,n,2);
                        upd(1,1,n,v,false);
                        d[v]:=false;
                        vv:=cnpg;
                        writeln(vv);
                        upg(1,1,n,vv,n,-2);
                        upd(1,1,n,vv,true);
                        d[vv]:=true;
                end else
                begin
                        upg(1,1,n,v,n,-2);
                        upd(1,1,n,v,true);
                        vv:=qd(1,1,n);
                        writeln(vv);
                        upg(1,1,n,vv,n,2);
                        upd(1,1,n,vv,false);
                        d[v]:=true;
                        d[vv]:=false;
                end;
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
