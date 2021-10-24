type    save=record l,r:longint;end;

const   ginp='equqnt.inp';
        gout='equqnt.out';
        maxch=1 shl 21-1;
        g:array['a'..'z'] of longint =(0,1,2,4,0,8,16,32,0,64,128,256,512,1024,0,2048,4096,8192,16384,32768,0,65536,131072,262144,524288,1048576);

var     n,q,nn:longint;
        a,b:ansistring;
        s:array[0..maxch] of save;
        d,ms:array['a'..'z'] of longint;
        f:array[0..5010] of longint;

procedure update(l,r,k:longint);
begin
        if (r-l>s[k].r-s[k].l) or (s[k].l=0) then
        begin
                s[k].r:=r;
                s[k].l:=l;
        end;
end;

procedure enter;
var     l,r,k,ch,tch:longint;
        i:char;
begin
        readln(n);
        readln(a);
        for l:=1 to n do
        begin
                fillchar(f,sizeof(f),0);
                fillchar(d,sizeof(d),0);
                for r:=l to n do inc(d[a[r]]);
                for i:='a' to 'z' do f[d[i]]:=f[d[i]]+g[i];
                for k:=0 to n-l+1 do update(l,n,f[k]);
                for r:=n-1 downto l do
                begin
                        dec(f[d[a[r+1]]],g[a[r+1]]);
                        update(l,r,f[d[a[r+1]]]);
                        dec(d[a[r+1]]);
                        inc(f[d[a[r+1]]],g[a[r+1]]);
                        update(l,r,f[d[a[r+1]]]);
                end;
        end;
        for ch:=maxch downto 1 do
                for k:=1 to 21 do
                begin
                        tch:=ch or (1 shl (k-1));
                        update(s[tch].l,s[tch].r,ch);
                end;
end;

procedure process;
var     tv,ms,i:longint;
begin
        readln(q);
        for tv:=1 to q do
        begin
                readln(b);
                nn:=0;
                while b[1] in ['0'..'9'] do
                begin
                        nn:=nn*10+ord(b[1])-48;
                        delete(b,1,1);
                end;
                delete(b,1,1);
                ms:=0;
                for i:=1 to nn do ms:=ms+g[b[i]];
                if s[ms].l=0 then writeln(-1) else writeln(s[ms].l,' ',s[ms].r);
        end;
end;

begin
        assign(input,ginp);assign(output,gout);
        reset(input);rewrite(output);
        enter;
        process;
        close(input);close(output);
end.
